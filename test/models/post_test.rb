require "test_helper"

class PostTest < ActiveSupport::TestCase
  def test_post_can_be_created
    Post.create(title: "aaaaa", body: "A"*200)
    assert_equal 1, Post.all.count
  end

  def test_title_should_be_present
    Post.create(body: "aaa")
    assert_equal 0, Post.all.count
  end

  def test_body_should_be_present
    Post.create(title: "aaa")
    assert_equal 0, Post.all.count
  end

  def test_title_should_have_min_5_symbol
    Post.create(title: "aaa", body: "aaaaa"*20)
    assert_equal 0, Post.all.count
  end

  def test_title_should_have_max_30_symbol
    Post.create(title: "aaa"*11, body: "aaaaa"*20)
    assert_equal 0, Post.all.count
  end

  def test_body_should_have_min_200_symbol
    Post.create(title: "aaaaa", body: "aaaaa")
    assert_equal 0, Post.all.count
  end
end
