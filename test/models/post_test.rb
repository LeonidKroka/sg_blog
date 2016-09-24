require "test_helper"

class PostTest < ActiveSupport::TestCase
  def test_title_should_be_present
    Post.create(body: "aaa")
    assert_equal 0, Post.all.count
  end

  def test_body_should_be_present
    Post.create(title: "aaa")
    assert_equal 0, Post.all.count
  end
end
