require "test_helper"

class PostControllerTest < ActionDispatch::IntegrationTest
  def setup
    create_ten_posts
    visit "/"
  end

  def test_post_must_have_create_page
    get "/posts/new"
    assert_equal 200, status
  end

  def test_post_must_have_edit_page
    get "/posts/1/edit"
    assert_equal 200, status
  end

  def test_post_must_have_action_delete
    delete "/posts/1"
    assert_equal 302, status
  end

  def test_button_new_post_show_posts_creat_pege
    page.click_button "New Post"
    assert page.has_content?(app_page_title_for[:new_post])
  end

  def test_button_edit_post_show_posts_edit_pege
    page.click_link Post.all[0].title
    page.click_button "Edit Post"
    assert_equal 1, page.all(".post-save").count
  end

  def test_button_delete_post_must_delete_this_post
    page.click_link "aaaa0"
    page.click_button "Delete"
    Post.all.each{|post| assert_not_equal post.title, "aaaa0"}
  end

  def test_button_delete_post_show_root_pege
    page.click_link Post.all[0].title
    page.click_button "Delete"
    assert page.has_content?(app_page_title_for[:root])
  end

  private
  def create_ten_posts
    3.times { |n| Post.create(title: "aaaa#{n}", body: "A"*200) }
  end

  def app_page_title_for
    {:root => "SG Blog",
     :new_post => "New post"}
  end

end
