require "test_helper"

class RootTest < ActiveSupport::TestCase
  def setup
    create_six_posts
    visit "/"
  end

  def test_visit_home_page_and_see_blog_title
    assert page.has_content?("SG Blog")
  end

  def test_visit_home_page_and_see_five_post_titles
    assert_equal 5, page.all(".list-group-item").count
  end

  private
  def create_six_posts
    6.times { |n| Post.create(title: "aaaa#{n}", body: "A"*200) }
  end

end
