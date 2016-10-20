require "test_helper"

class PostCommentTest < ActionDispatch::IntegrationTest
  def setup
    Post.create(title: "aaaa1", body: "A"*200)
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

  def test_coment_form_should_have_error_message
    visit post_path(id: 1)
    find("#comment_body").set("a"*201)
    find("#new_comment.new_comment").click
    assert page.has_selector? ("div.alert-errors")
  end

  def test_one_page_show_only_ten_comments
    11.times {|n| Post.all[0].comments.create(:body => "valid_#{n}")}
    visit "/posts/1"
    assert_equal 10, page.all(".list-group-item").count
    assert_equal 2, (page.all(".pagination li").count-4)/2
  end

end
