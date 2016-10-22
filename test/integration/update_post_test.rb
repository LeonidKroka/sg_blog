require "test_helper"

class EditPostTest < ActiveSupport::TestCase
  def setup
    Post.create(title: "aaaa1", body: "A"*200)
    visit "/posts/1/edit"
  end

  def test_edit_post_and_press_submit_should_update_this_post_and_show_updated_post
    fill_in("Title", :with => post_content[:title][:valid])
    fill_in("Body", :with => post_content[:body][:valid])
    click_button "Make'em edit"
    assert page.has_content?(post_content[:title][:valid])
    assert_equal 1, Post.all.count
    assert_equal post_content[:title][:valid], Post.all[0].title
  end

  def test_show_error_message_when_post_can_not_be_updated
    fill_in("Title", :with => post_content[:title][:invalid])
    fill_in("Body", :with => post_content[:body][:invalid])
    click_button "Make'em edit"
    assert page.has_content?(error_message)
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
