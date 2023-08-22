appraise 'hanami-1' do
  gem 'rack'
  gem 'rack-test'
  gem 'hanami', '~> 1'
end

appraise 'rails5-mysql2' do
  gem 'rails', '~> 5.2.1'
  gem 'mysql2', '< 1'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
end

appraise 'rails5-postgres' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
end

appraise 'rails5-semantic-logger' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0'
  gem 'sprockets', '< 4'
  gem 'rails_semantic_logger', '~> 4.0'
end

appraise 'rails5-postgres-redis' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0'
  gem 'redis', '>= 4.0.1'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
end

appraise 'rails5-postgres-redis-activesupport' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0'
  gem 'redis', '>= 4.0.1'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'redis-rails'
end

appraise 'rails5-postgres-sidekiq' do
  gem 'rails', '~> 5.2.1'
  gem 'pg', '< 1.0'
  gem 'sidekiq'
  gem 'activejob'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
end

appraise 'resque2-redis3' do
  gem 'redis', '< 4.0'
  gem 'resque', '>= 2.0'
end

appraise 'resque2-redis4' do
  gem 'redis', '>= 4.0'
  gem 'resque', '>= 2.0'
end

(3..4).each { |v| gem_cucumber(v) }

appraise 'contrib' do
  gem 'actionpack'
  gem 'actionview'
  gem 'active_model_serializers', '>= 0.10.0'
  gem 'activerecord', '< 5.1.5'
  gem 'aws-sdk'
  gem 'concurrent-ruby'
  gem 'dalli', '< 3.0.0' # Dalli 3.0 dropped support for Ruby < 2.5
  gem 'delayed_job'
  gem 'delayed_job_active_record'
  gem 'ethon'
  gem 'excon'
  gem 'faraday', '>= 1.0'
  gem 'grape'
  gem 'graphql', '>= 2.0'
  gem 'grpc'
  gem 'google-protobuf', '~> 3.11.0' # Last version to support Ruby < 2.5
  gem 'http'
  gem 'httpclient'
  gem 'lograge', '~> 0.11'
  gem 'makara'
  gem 'mongo', '>= 2.8.0', '< 2.15.0' # TODO: FIX TEST BREAKAGES ON >= 2.15 https://github.com/DataDog/dd-trace-rb/issues/1596
  gem 'minitest', '>= 5.0.0'
  gem 'mysql2', '< 0.5'
  gem 'opensearch-ruby'
  gem 'pg', '>= 0.18.4'
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
  gem 'sqlite3', '~> 1.3.6'
  gem 'stripe', '~> 6.0'
  gem 'sucker_punch'
  gem 'typhoeus'
  gem 'que', '>= 1.0.0', '< 2.0.0'
end

appraise 'activerecord-4' do
  gem 'activerecord', '~> 4'
  gem 'mysql2'
  gem 'sqlite3', '~> 1.3.0'
  gem 'makara', '~> 0.3.0'
end

appraise 'sinatra' do
  gem 'sinatra'
  gem 'rack-test'
end

[3, 4].each do |n|
  appraise "redis-#{n}" do
    gem 'redis', "~> #{n}"
  end
end

appraise 'contrib-old' do
  gem 'elasticsearch', '< 8.0.0' # Dependency elasticsearch-transport renamed to elastic-transport in >= 8.0
  gem 'faraday', '0.17'
  gem 'graphql', '~> 1.12.0', '< 2.0' # TODO: Support graphql 1.13.x
  gem 'presto-client', '>= 0.5.14' # Renamed to trino-client in >= 1.0
end

appraise 'core-old' do
  gem 'dogstatsd-ruby', '~> 4'
end
