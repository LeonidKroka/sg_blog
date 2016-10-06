module PostsHelper
  def limited_posts_body body
    "#{body[0..99]}..."
  end
end
