class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates_presence_of :title, :body
  validates :title, length: { in: 5..30 }
  validates :title, format: { with: /[\s]{0,1}[a-zA-Z0-9]+/ }
  validates :body, length: { minimum: 200 }

  mount_uploader :image, ImageUploader

  def self.latest_five
    order(created_at: :desc).limit(5)
  end
end
