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

  def test_root_must_have_search_field
    assert_equal 1, page.all(".form-control").count
    assert page.has_content?("Search")
  end

  def test_search_post
    fill_in("Title", :with => "aaaa1")
    click_on "Search!"
    sleep(3)
    assert page.has_content?("aaaa1")
    assert page.has_no_content?("aaaa2")
  end

  def test_search_wrong_post
    fill_in("Title", :with => "aaaaa")
    click_on "Search!"
    sleep(3)
    assert page.has_content?("There are no result's")
    assert page.has_no_content?("aaaaa")
  end

  private
  def create_six_posts
    6.times { |n| Post.create(title: "aaaa#{n}", body: "A"*200) }
  end

end
