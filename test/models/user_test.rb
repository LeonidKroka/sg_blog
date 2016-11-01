require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new( login: "True_login",
                      email: "true_mail@example.com",
                      password: "True0pass",
                      password_confirmation: "True0pass")
  end

  def test_login_validation
    user_data[:login][:invalid].each do |login|
      @user.login = login
      assert @user.invalid?
    end
    user_data[:login][:valid].each do |login|
      @user.login = login
      assert @user.valid?
    end
  end

  def test_email_validation
    user_data[:email][:invalid].each do |email|
      @user.email = email
      assert @user.invalid?
    end
    user_data[:email][:valid].each do |email|
      @user.email = email
      assert @user.valid?
    end
  end

  def test_password_validation
    user_data[:pass][:invalid].each do |pass|
      @user.password = pass
      @user.password_confirmation = pass
      assert @user.invalid?
    end
    user_data[:pass][:valid].each do |pass|
      @user.password = pass
      @user.password_confirmation = pass
      assert @user.valid?
    end
  end

  private
    def user_data
      {:login => {:valid => ["aaaaa", "some_text", "SOME_TEXT"],
                  :invalid => ["", "aaaa", "a"*20, "some@text", "_aaaaa_"]},
       :email => {:valid => ["user@foo.COM", "A_US-ER@f.b.org", "frst.lst@foo.jp", "a+b@baz.cn"],
                  :invalid => ["user@foo,com", "user_at_foo.org", "example.user@foo.foo@bar_baz.com"]},
       :pass => {:valid => ["Aaaa1", "1Aaaaa", "a1aaaAA"],
                 :invalid => ["12345", "Aa1", "aaaaa", "aaaaa1", "Aaaaaa"]} }
    end
end
