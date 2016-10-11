require "test_helper"

class CommentTest < ActiveSupport::TestCase

  def test_coment_can_be_valid
    assert Comment.new(:body => "some text").valid?
  end

  def test_coment_shoud_not_created_when_it_has_more_200_length
    assert_not Comment.new(:body => "a"*201).valid?
  end

end
