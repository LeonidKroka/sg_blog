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
  include SessionsHelper
  include Capybara::DSL
  self.use_transactional_fixtures = false
  DatabaseCleaner.strategy = :truncation
  Capybara.default_driver = :webkit
  Capybara.javascript_driver = :webkit
  Capybara.default_max_wait_time = 10
  Capybara::Webkit.configure do |config|
    config.allow_unknown_urls
    config.ignore_ssl_errors
  end

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
end

module SessionLogIn
  def log_in_as_new_user
    @user = User.create( login: "True_login",
                         email: "true_mail@example.com",
                         password: "True0pass",
                         password_confirmation: "True0pass",
                         latitude: "50",
                         longitude: "50" )
    visit "/login"
    find('#session_login').set(@user.login)
    find('#session_password').set(@user.password)
    find(:css, "#session_remember_me").set(true)
    within('.sessions-forms') { click_on "Log in" }
    sleep(3)
  end
end
