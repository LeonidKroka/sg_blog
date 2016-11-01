class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  VALID_LOGIN_REGEX = /\A[a-zA-Z]+_{0,1}[a-zA-Z]+\z/
  validates :login, presence: true,
                    length: { in: 5..15 },
                    format: { with: VALID_LOGIN_REGEX },
                    uniqueness: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  VALID_PASS_REGEX = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]*\z/
  validates :password, presence: true,
                       length: { minimum: 5 },
                       format: { with: VALID_PASS_REGEX , message: "must include lower, upper letter and num"}

  has_secure_password
end
