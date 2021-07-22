# frozen_string_literal: true

ruby '2.5.0'

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk', '~> 3.0', '>= 3.0.1'
gem 'aws-sdk-sqs'
gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'factory_bot_rails'
gem 'jsonapi-serializers'
gem 'mailjet'
gem 'paperclip', '~> 6.0'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 5.1.4'
gem 'rest-client', '~> 2.0', '>= 2.0.2'

gem 'brakeman', require: false
gem 'byebug', platforms: %i[mri mingw x64_mingw]
gem 'cane', require: false
gem 'database_cleaner'
gem 'json-schema'
gem 'rails_best_practices'
gem 'rspec-rails'
gem 'rubocop'
gem 'rubocop-rspec'
gem 'shoryuken'
gem 'simplecov'

gem 'listen', '>= 3.0.5', '< 3.2'
gem 'spring'
gem 'spring-watcher-listen', '~> 2.0.0'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'webmock'
group :test do
  gem 'cucumber-rails', require: false
end
