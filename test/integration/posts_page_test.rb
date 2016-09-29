require "test_helper"

class PostPageTest < ActiveSupport::TestCase
  def setup
    3.times { |n| Post.create(title: "aaaa#{n}", body: "AAAAA"*20+"#{n}") }
  end

  def test_posts_title_should_be_present
    posts_db_each_visit{|post| assert (page.has_content? (post.title)) }
  end

  def test_other_posts_title_should_not_be_present
    posts_db_each_visit do |post|
      Post.all.each{|other_post| (assert page.has_no_content?(other_post.title)) if (other_post != post) }
    end
  end

  def test_posts_body_should_be_present
    posts_db_each_visit{|post| assert (page.has_content? (post.body)) }
  end

  def test_other_posts_body_should_not_be_present
    posts_db_each_visit do |post|
      Post.all.each{|other_post| (assert page.has_no_content?(other_post.body)) if (other_post != post) }
    end
  end

  def test_buttons_should_be_present
    posts_db_each_visit{ assert_equal 2, page.all("button.post-action").count }
  end

  private
  def posts_db_each_visit &block
    Post.all.each do |post|
      visit "/posts/#{post.id}"
      yield post
    end
  end

end
