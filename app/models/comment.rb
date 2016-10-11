class Comment < ActiveRecord::Base
  belongs_to :post

  validates_presence_of :body
  validates :body, length: { maxsimum: 200}

  def self.latest_ten
    order(created_at: :desc).limit(10)
  end
end
