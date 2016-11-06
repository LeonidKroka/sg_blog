require "test_helper"

class PostCommentTest < ActionDispatch::IntegrationTest
  include SessionLogIn

  def setup
    Post.create(title: "Some text",
                body: "A"*200,
                user_id: 1)
    log_in_as_new_user
  end

  def test_create_new_valid_comment
    post post_comments_path(post_id: 1), xhr: true,
                                         :comment => {body: "Some short text"},
                                         format: :js
    assert_equal 1, Post.all[0].comments.count
  end

  def test_can_not_create_invalid_comment
    post post_comments_path(post_id: 1), xhr: true,
                                         :comment => {body: "a"*201},
                                         format: :js
    assert_equal 0, Post.all[0].comments.count
  end

  def test_create_new_valid_comment
    visit post_path(id: 1)
    find("#comment_body").set("Something")
    click_on "It's ok!"
    assert page.has_content? ("Something")
  end

  def test_invalid_coment_form_should_have_error_message_and_red_border
    visit post_path(id: 1)
    find("#comment_body").set("a"*201)
    click_on "It's ok!"
    within("div.alert-errors") { assert page.has_content? ("is too long") }
    assert page.find_by_id('comment_body')[:style].include?('red')
  end

  def test_invalid_coment_edit_form_should_have_error_message_and_red_border
    Post.all[0].comments.create(:body => "valid",
                                :user_id => 1)
    visit post_path(id: 1)
    within("div.comments") { click_on "Edit" }
    within("div.comment-edit-forms") do
      find("#comment_body").set("a"*201)
      click_on "Now ok!"
      assert page.has_content? ("is too long")
      assert page.find_by_id('comment_body')[:style].include?('red')
    end
  end

  def test_valid_coment_edit_should_update_comment_and_hide_comment_edit_form
    Post.all[0].comments.create(:body => "valid",
                                :user_id => 1)
    visit post_path(id: 1)
    within("div.comments") { click_on "Edit" }
    within("div.comment-edit-forms") do
      find("#comment_body").set("Something")
      click_on "Now ok!"
    end
    within("div.comments") { assert page.has_content? ("Something") }
    assert_equal 0, page.all(".comment-edit-forms").count
  end

  def test_one_page_show_only_ten_comments
    11.times {|n| Post.all[0].comments.create(:body => "valid_#{n}",
                                              :user_id => 1)}
    visit "/posts/1"
    assert_equal 10, page.all(".list-group-item").count
    assert_equal 2, (page.all(".pagination li").count-4)/2
  end

  def test_destroy_comment
    visit post_path(id: 1)
    find("#comment_body").set("Text to destroy")
    click_on "It's ok!"
    assert page.has_content?("Text to destroy")
    assert_equal 1, Comment.all.count
    within("div.comments") do
      click_on "Delete"
      assert_not page.has_content?("Text to destroy")
      assert_equal 0, Comment.all.count
    end
  end
end
