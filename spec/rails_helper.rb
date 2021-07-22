# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'simplecov'
require 'database_cleaner'
require 'support/json_api_matchers'

SimpleCov.minimum_coverage 90
SimpleCov.start 'rails'

ActiveRecord::Migration.maintain_test_schema!

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
