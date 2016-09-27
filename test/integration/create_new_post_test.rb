require "test_helper"

class NewPostTest < ActiveSupport::TestCase
  def setup
    visit "/posts/new"
  end

  def test_create_new_post_and_press_submit
    fill_in("Title", :with => "True title")
    fill_in("Body", :with => "Very long text"*20)
    click_button "Create Post"
    assert_equal 1, Post.all.count
  end

  def test_show_error_message_when_post_should_not_be_created
    fill_in("Title", :with => "fail")
    fill_in("Body", :with => "Very long text"*20)
    click_button "Create Post"
    assert page.has_content?("Sorry, your post is not valid. Please, try again.")
  end

  def test_show_post_after_it_should_be_created
    fill_in("Title", :with => "True title")
    fill_in("Body", :with => "Very long text"*20)
    click_button "Create Post"
    assert page.has_content?("True title")
  end

end
