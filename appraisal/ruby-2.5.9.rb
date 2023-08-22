appraise 'hanami-1' do
  gem 'rack'
  gem 'rack-test'
  gem 'hanami', '~> 1'
end

appraise 'rails5-mysql2' do
  gem 'rails', '~> 5.2.1'
  gem 'mysql2', '< 1', platform: :ruby
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'mail', '~> 2.7.1' # Somehow 2.8.x breaks ActionMailer test in jruby
end

appraise 'rails5-postgres' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails5-semantic-logger' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'rails_semantic_logger', '~> 4.0'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails5-postgres-redis' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'redis', '>= 4.0.1'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails5-postgres-redis-activesupport' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'redis', '~> 4'
  gem 'redis-store', '~> 1.9'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'redis-rails'
end

appraise 'rails5-postgres-sidekiq' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sidekiq'
  gem 'activejob'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails6-mysql2' do
  gem 'rails', '~> 6.0.0'
  gem 'mysql2', '< 1', platform: :ruby
  gem 'activerecord-jdbcmysql-adapter', '>= 60', platform: :jruby # try remove >= 60
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'mail', '~> 2.7.1' # Somehow 2.8.x breaks ActionMailer test in jruby
end

appraise 'rails6-postgres' do
  gem 'rails', '~> 6.0.0'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 60', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails6-semantic-logger' do
  gem 'rails', '~> 6.0.0'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 60', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'rails_semantic_logger', '~> 4.0'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails6-postgres-redis' do
  gem 'rails', '~> 6.0.0'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 60', platform: :jruby
  gem 'redis', '>= 4.0.1'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails6-postgres-redis-activesupport' do
  gem 'rails', '~> 6.0.0'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 60', platform: :jruby
  gem 'redis', '~> 4'
  gem 'redis-store', '~> 1.9'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'redis-rails'
end

appraise 'rails6-postgres-sidekiq' do
  gem 'rails', '~> 6.0.0'
  gem 'pg', '< 1.0', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 60', platform: :jruby
  gem 'sidekiq'
  gem 'activejob'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails61-mysql2' do
  gem 'rails', '~> 6.1.0'
  gem 'mysql2', '~> 0.5', platform: :ruby
  gem 'activerecord-jdbcmysql-adapter', '>= 61', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'mail', '~> 2.7.1' # Somehow 2.8.x breaks ActionMailer test in jruby
end

appraise 'rails61-postgres' do
  gem 'rails', '~> 6.1.0'
  gem 'pg', '>= 1.1', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 61', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails61-postgres-redis' do
  gem 'rails', '~> 6.1.0'
  gem 'pg', '>= 1.1', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 61', platform: :jruby
  gem 'redis', '>= 4.2.5'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails61-postgres-sidekiq' do
  gem 'rails', '~> 6.1.0'
  gem 'pg', '>= 1.1', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 61', platform: :jruby
  gem 'sidekiq', '>= 6.1.2'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'rails61-semantic-logger' do
  gem 'rails', '~> 6.1.0'
  gem 'pg', '>= 1.1', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 61', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'rails_semantic_logger', '~> 4.0'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
end

appraise 'resque2-redis3' do
  gem 'redis', '< 4.0'
  gem 'resque', '>= 2.0'
end

appraise 'resque2-redis4' do
  gem 'redis', '>= 4.0'
  gem 'resque', '>= 2.0'
end

(3..5).each { |v| gem_cucumber(v) }

appraise 'contrib' do
  gem 'actionpack'
  gem 'actionview'
  gem 'active_model_serializers', '>= 0.10.0'
  gem 'activerecord', '~> 5'
  gem 'aws-sdk'
  gem 'concurrent-ruby'
  gem 'dalli', '>= 3.0.0'
  gem 'delayed_job'
  gem 'delayed_job_active_record'
  gem 'elasticsearch', '>= 8.0.0'
  # Workaround bundle of JRuby/ethon issues:
  # * ethon 0.15.0 is incompatible with most JRuby 9.2 versions (fixed in 9.2.20.0),
  #   see https://github.com/typhoeus/ethon/issues/205
  # * we test with 9.2.18.0 because ethon is completely broken on JRuby 9.2.19.0+ WHEN RUN on a Java 8 VM,
  #   see https://github.com/jruby/jruby/issues/7033
  #
  # Thus let's keep our JRuby testing on 9.2.18.0 with Java 8, and avoid pulling in newer ethon versions until
  # either the upstream issues are fixed OR we end up moving to Java 11.
  gem 'ethon', (RUBY_PLATFORM == 'java' ? '< 0.15.0' : '>= 0')
  gem 'excon'
  gem 'faraday', '>= 1.0'
  gem 'grape'
  gem 'graphql', '>= 2.0'
  gem 'grpc', platform: :ruby
  gem 'http'
  gem 'httpclient'
  gem 'lograge', '~> 0.11'
  gem 'i18n', '1.8.7', platform: :jruby # Removal pending: https://github.com/ruby-i18n/i18n/issues/555#issuecomment-772112169
  gem 'makara'
  gem 'minitest', '>= 5.0.0'
  gem 'mongo', '>= 2.8.0', '< 2.15.0' # TODO: FIX TEST BREAKAGES ON >= 2.15 https://github.com/DataDog/dd-trace-rb/issues/1596
  gem 'mysql2', '< 1', platform: :ruby
  gem 'activerecord-jdbcmysql-adapter', '>= 52', platform: :jruby
  gem 'opensearch-ruby'
  gem 'pg', '>= 0.18.4', platform: :ruby
  gem 'activerecord-jdbcpostgresql-adapter', '>= 52', platform: :jruby
  gem 'racecar', '>= 0.3.5'
  gem 'rack'
  gem 'rack-contrib'
  gem 'rack-test'
  gem 'rake', '>= 12.3'
  gem 'rest-client'
  gem 'resque'
  gem 'roda', '>= 2.0.0'
  gem 'ruby-kafka', '>= 0.7.10'
  gem 'rspec', '>= 3.0.0'
  gem 'semantic_logger', '~> 4.0'
  gem 'sequel', '~> 5.54.0' # TODO: Support sequel 5.62.0+
  gem 'shoryuken'
  gem 'sidekiq'
  gem 'sneakers', '>= 2.12.0'
  gem 'bunny', '~> 2.19.0' # uninitialized constant OpenSSL::SSL::TLS1_3_VERSION for jruby, https://github.com/ruby-amqp/bunny/issues/645
  gem 'sqlite3', '~> 1.4.1', platform: :ruby
  gem 'stripe', '~> 7.0'
  gem 'activerecord-jdbcsqlite3-adapter', '>= 52', platform: :jruby
  gem 'sucker_punch'
  gem 'typhoeus'
  gem 'que', '>= 1.0.0', '< 2.0.0'
end

appraise 'sinatra' do
  gem 'sinatra'
  gem 'rack-test'
end

[3, 4, 5].each do |n|
  appraise "redis-#{n}" do
    gem 'redis', "~> #{n}"
  end
end

appraise 'contrib-old' do
  gem 'dalli', '< 3.0.0'
  gem 'elasticsearch', '< 8.0.0' # Dependency elasticsearch-transport renamed to elastic-transport in >= 8.0
  gem 'faraday', '0.17'
  gem 'graphql', '~> 1.12.0', '< 2.0' # TODO: Support graphql 1.13.x
  gem 'presto-client', '>= 0.5.14' # Renamed to trino-client in >= 1.0

  if RUBY_PLATFORM == 'java'
    gem 'qless', '0.10.0' # Newer releases require `rusage`, which is not available for JRuby
    gem 'redis', '< 4' # Missing redis version cap for `qless`
  else
    gem 'qless', '0.12.0'
  end
end

appraise 'core-old' do
  gem 'dogstatsd-ruby', '~> 4'
end
