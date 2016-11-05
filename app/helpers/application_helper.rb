module ApplicationHelper
  def author? model
    logged? && current_user == User.find_by(id: model.user_id)
  end
end
