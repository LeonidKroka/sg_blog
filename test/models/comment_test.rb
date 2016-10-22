require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def test_comment_validation
    comment_body[:invalid].each do |body|
      assert Comment.new(body: body).invalid?
    end
    comment_body[:valid].each do |body|
      assert Comment.new(body: body).valid?
    end
  end

  private
    def comment_body
      {:valid => ["+", "Some text", "First chang in post", "HTTP-server"],
       :invalid => ["", "a"*201, "afsdfhttp://vk.comdfas", "some first post"]}
    end
end
