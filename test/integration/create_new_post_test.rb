require "test_helper"

class NewPostTest < ActiveSupport::TestCase
  def setup
    visit "/posts/new"
  end

  def test_create_new_post_and_press_submit_must_add_new_post
    fill_in("Title", :with => post_content[:title][:valid])
    fill_in("Body", :with => post_content[:body][:valid])
    click_button "Make'em create"
    assert_equal 1, Post.all.count
  end

  def test_show_error_message_when_post_should_not_be_created
    fill_in("Title", :with => post_content[:title][:invalid])
    fill_in("Body", :with => post_content[:body][:valid])
    click_button "Make'em create"
    assert page.has_content?(error_message)
  end

  def test_show_post_after_it_should_be_created
    fill_in("Title", :with => post_content[:title][:valid])
    fill_in("Body", :with => post_content[:body][:valid])
    click_button "Make'em create"
    assert page.has_content?(post_content[:title][:valid])
  end

  def test_can_add_image_when_new_creating
    fill_in("Title", :with => post_content[:title][:valid])
    fill_in("Body", :with => post_content[:body][:valid])
    attach_file("post_image", "#{Rails.root}/test/fixtures/files/some.jpg")
    click_button "Make'em create"
    assert page.has_selector?("img")
  end

  private
  def post_content
    {:title => {:valid => "True title",
                :invalid => "Fail"},
     :body => {:valid => "Very long text"*20,
               :invalid => "Short text"}}
  end

  def error_message
    "Sorry, your post is not valid. Please, try again."
  end

end
