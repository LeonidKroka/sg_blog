require "test_helper"

class PostPageTest < ActiveSupport::TestCase
  include SessionLogIn

  def setup
    log_in_as_new_user
    Post.create(title: "aaaa1",
                body: "AAAAA"*200+"1",
                user_id: 1)
    Post.create(title: "aaaa2",
                body: "AAAAA"*200+"2",
                image: File.open("#{Rails.root}/test/fixtures/files/some.jpg"),
                user_id: 1)
    sleep(3)
    visit "/posts/1"
  end

  def test_posts_data_should_be_present
    assert page.has_content?(Post.all[0].title)
    assert page.has_content?(Post.all[0].body)
  end

  def test_other_posts_title_should_not_be_present
    assert page.has_no_content?(Post.all[1].title)
    assert page.has_no_content?(Post.all[1].body)
  end

  def test_buttons_should_be_present
    assert page.has_content?("Edit")
    assert page.has_content?("Delete")
  end

  def test_posts_img_should_be_present_only_if_it_added_to_post
    sleep(3)
    assert page.has_no_selector?("img")
    visit "/posts/2"
    sleep(3)
    assert page.has_selector?("img")
  end

  def test_show_page_must_have_comments_form
    visit "/posts/1"
    sleep(3)
    assert page.has_selector?("textarea")
  end
end
