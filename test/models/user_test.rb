require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new( login: "True_login",
                      email: "true_mail@example.com",
                      password: "True0pass",
                      password_confirmation: "True0pass")
  end

  def test_login_validation
    validation user_data[:login] {|value| @user.login = value}
  end

  def test_email_validation
    validation user_data[:email] {|value| @user.email = value}
  end

  def test_password_validation
    validation user_data[:pass] do |value|
      @user.password = value
      @user.password_confirmation = value
    end
  end

  def test_authenticated_method
    assert_not @user.authenticated?(:activation, '')
  end

  private
    def validation(hash, &block)
      hash[:invalid].each do |invalid|
        yield invalid
        assert @user.invalid?
      end
      hash[:valid].each do |valid|
        yield valid
        assert @user.valid?
      end
    end

    def user_data
      {:login => {:valid => ["aaaaa", "some_text", "SOME_TEXT"],
                  :invalid => ["", "aaaa", "a"*20, "some@text", "_aaaaa_"]},
       :email => {:valid => ["user@foo.COM", "A_US-ER@f.b.org", "frst.lst@foo.jp", "a+b@baz.cn"],
                  :invalid => ["user@foo,com", "user_at_foo.org", "example.user@foo.foo@bar_baz.com"]},
       :pass => {:valid => ["Aaaa1", "1Aaaaa", "a1aaaAA"],
                 :invalid => ["12345", "Aa1", "aaaaa", "aaaaa1", "Aaaaaa"]} }
    end
end
