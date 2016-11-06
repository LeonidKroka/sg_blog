require "test_helper"

class HeaderTest < ActiveSupport::TestCase
  include SessionLogIn

  def setup
    visit "/"
  end

  def test_unlogged_header
    within('header') do
      assert page.has_content?('SG BLOG')
      assert page.has_content?('Log in')
      assert_not page.has_content?('Create new post')
      assert_not page.has_content?('My profile')
      assert_not page.has_selector?('img')
    end
  end

  def test_logged_header
    log_in_as_new_user
    within('header') do
      assert page.has_content?('SG BLOG')
      assert_not page.has_content?('Log in')
      assert page.has_content?('Create new post')
      assert page.has_content?('My profile')
      assert page.has_selector?('img')
      find('.dropdown-toggle').click()
      assert page.has_content?('Log out')
    end
  end
end
