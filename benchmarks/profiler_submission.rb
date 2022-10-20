# typed: false

# Used to quickly run benchmark under RSpec as part of the usual test suite, to validate it didn't bitrot
VALIDATE_BENCHMARK_MODE = ENV['VALIDATE_BENCHMARK'] == 'true'

return unless __FILE__ == $PROGRAM_NAME || VALIDATE_BENCHMARK_MODE

require 'benchmark/ips'
require 'ddtrace'
require 'datadog/core/utils/compression'
require 'pry'
require 'digest'
require_relative 'dogstatsd_reporter'

# This benchmark measures the performance of encoding pprofs and trying to submit them
#
# The FLUSH_DUMP_FILE (by default benchmarks/data/profiler-submission-marshal.gz, gathered from benchmarking using
# the discourse forum rails app) can be generated by changing the scheduler.rb#flush_events to dump the contents of
# "flush" to a file during a benchmark execution:
#
# dump_file = "marshal-#{Time.now.utc.to_i}.dump"
# File.open(dump_file, "w") { |f| Marshal.dump(flush, f) }
# Datadog.logger.info("Dumped to #{dump_file}")
#
# And then gzipping the result. (This can probably be automated a bit by adding an extra exporter, but the above worked
# for me).

class ProfilerSubmission
  OldFlush =
    Struct.new(
    :start,
    :finish,
    :event_groups,
    :event_count,
    :code_provenance,
    :runtime_id,
    :service,
    :env,
    :version,
    :host,
    :language,
    :runtime_engine,
    :runtime_platform,
    :runtime_version,
    :profiler_version,
    :tags
  )

  def initialize
    # @ivoanjo: Hack to allow unmarshalling the old data; this will all need to be redesigned once we start using
    # libddprof for profile encoding, so I decided to take a shorter route for now.
    original_flush_class = Datadog::Profiling::Flush
    Datadog::Profiling.const_set(:Flush, OldFlush)
    flush = Marshal.load(
      Zlib::GzipReader.new(File.open(ENV['FLUSH_DUMP_FILE'] || 'benchmarks/data/profiler-submission-marshal.gz'))
    )
    Datadog::Profiling.const_set(:Flush, original_flush_class)

    @profiling_data = {event_count: flush.event_count, event_groups: flush.event_groups, start: flush.start, finish: flush.finish}
  end

  def check_valid_pprof
    expected_hashes = [
      "395dd7e65b35be6eede78ac9be072df8d6d79653f8c248691ad9bdd1d8b507de",
    ]
    current_hash = Digest::SHA256.hexdigest(Datadog::Core::Utils::Compression.gunzip(@output_pprof))

    if expected_hashes.include?(current_hash)
      puts "Output hash #{current_hash} matches known signature"
    else
      puts "WARNING: Unexpected pprof output -- unknown hash (#{current_hash}). Hashes seem to differ due to some of our dependencies changing, " \
        "but it can also indicate that encoding output has become corrupted."
    end
  end

  def run_benchmark
    Benchmark.ips do |x|
      benchmark_time = VALIDATE_BENCHMARK_MODE ? {time: 0.01, warmup: 0} : {time: 70, warmup: 2}
      x.config(**benchmark_time, suite: report_to_dogstatsd_if_enabled_via_environment_variable(benchmark_name: 'profiler_submission_v3'))

      x.report("exporter #{ENV['CONFIG']}") do
        run_once
      end

      x.save! 'profiler-submission-results.json' unless VALIDATE_BENCHMARK_MODE
      x.compare!
    end
  end

  def run_forever
    while true
      run_once
      print '.'
    end
  end

  def run_once
    @output_pprof =
      Datadog::Core::Utils::Compression.gzip(Datadog::Profiling::Encoding::Profile::Protobuf.encode(**@profiling_data))
  end
end

puts "Current pid is #{Process.pid}"

ProfilerSubmission.new.instance_exec do
  run_once
  check_valid_pprof

  if ARGV.include?('--forever')
    run_forever
  else
    run_benchmark
  end
end
