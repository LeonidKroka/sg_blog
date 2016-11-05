module CommentsHelper
  def link_to_commenter comment
    commenter = User.find_by(id: comment.user_id)
    link_to "#{commenter.login}", user_path(commenter)
  end
end
