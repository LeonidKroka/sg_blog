ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require 'headless'

class ActiveSupport::TestCase
  include Capybara::DSL
  Capybara.default_driver = :rack_test
  self.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation

  Capybara.default_max_wait_time = 10

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  self.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation
  Capybara.default_driver = :webkit
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 10

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
end
