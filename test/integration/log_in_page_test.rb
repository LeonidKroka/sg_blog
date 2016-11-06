require "test_helper"

class LogInPageTest < ActionDispatch::IntegrationTest
  def setup
    visit '/login'
  end

  def test_page_must_have_log_in_content
    assert page.has_content?('Log in to your account')
    assert page.has_selector?('form')
    assert_equal 1, page.all('label').count
    assert_equal 1, page.all('#session_remember_me').count
    assert page.has_content?('Remember me')
    within('.text-center') do
      assert page.has_selector?('button')
      assert page.has_content?('Log in')
    end
  end

  def test_page_content_when_wrong_log_in_action
    within('.sessions-forms') { click_on "Log in" }
    sleep(1)
    assert page.has_content?('Invalid login/password combination')
  end
end
