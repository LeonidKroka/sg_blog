class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  VALID_REGEX = /\A(?!.*(first post|http:\/\/|https:\/\/)).*\z/i
  validates :body, presence: true,
                   length: { in: 1..200},
                   format: { with: VALID_REGEX }

  def self.latest_ten
    order(created_at: :desc).limit(10)
  end
end
