require "test_helper"

class EditPostTest < ActiveSupport::TestCase
  def setup
    Post.create(title: "aaaa1", body: "A"*200)
  end

#  def test_create_new_valid_comment_and_view_it_in_this_page
#    visit "/posts/1"
#    find('textarea').set("Some short text")
#    find("#new_comment").find('button').click()
#    assert_equal 1, Post.all[0].comments.count
#    assert page.has_content? "Some short text"
#  end
#
#  def test_can_not_create_invalid_comment
#    visit "/posts/1"
#    find('textarea').set("a"*201)
#    find("#new_comment").find('button').click
#    assert_equal 0, Post.all[0].comments.count
#  end

  def test_one_page_show_only_ten_comments
    11.times {|n| Post.all[0].comments.create(:body => "valid_#{n}")}
    visit "/posts/1"
    assert_equal 10, page.all(".list-group-item").count
    assert_equal 2, (page.all(".pagination li").count-4)/2
  end

end
