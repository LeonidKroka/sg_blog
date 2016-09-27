require "test_helper"

class RootTest < ActiveSupport::TestCase
  def test_button_new_post_show_posts_creat_pege
    visit "/"
    page.click_button "New Post"
    assert page.has_content?("New post")
  end
end
