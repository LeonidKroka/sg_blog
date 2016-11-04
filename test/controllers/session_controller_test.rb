require "test_helper"

class SessinControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create( login: "True_login",
                         email: "true_mail@example.com",
                         password: "True0pass",
                         password_confirmation: "True0pass",
                         latitude: "50",
                         longitude: "50")
    visit "/login"
  end

  def test_log_in
    find('#session_login').set(@user.login)
    find('#session_password').set(@user.password)
    find(:css, "#session_remember_me").set(true)
    click_on "Log in"
    sleep(1)
    assert User.all[0].authenticated?(:remember, page.driver.cookies['remember_token'])
    assert page.has_content?(@user.email)
  end

  def test_wrong_log_in
    find('#session_login').set("wrong_login")
    find('#session_password').set(@user.password)
    find('#session_remember_me').set(true)
    click_on "Log in"
    sleep(1)
    assert_not User.all[0].authenticated?(:remember, page.driver.cookies['remember_token'])
    assert page.has_no_content?(@user.email)
    assert page.has_content?('Log in to your account')
    assert page.has_content?('Invalid login/password combination')
  end

  def test_log_in_without_remember
    find('#session_login').set(@user.login)
    find('#session_password').set(@user.password)
    click_on "Log in"
    sleep(1)
    assert_not User.all[0].authenticated?(:remember, page.driver.cookies['remember_token'])
    assert page.has_content?(@user.email)
  end
end
