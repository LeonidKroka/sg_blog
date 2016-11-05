module PostsHelper
  def limited_posts_body body
    "#{body[0..99]}..."
  end

  def date_format strtime
    strtime.strftime('%B %d, %H:%M:%S')
  end
end
