class Post < ActiveRecord::Base

  validates_presence_of :title, :body
  validates :title, length: { in: 5..30 }
  validates :title, format: { with: /[\s]{0,1}[a-zA-Z0-9]+/ }
  validates :body, length: { minimum: 200 }

end
