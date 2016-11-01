require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.create( login: "truelogin",
                      email: "true_mail@example.com",
                      password: "True0pass",
                      password_confirmation: "True0pass")
    @user.activation_token = User.new_token
  end

  def test_account_activation
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_equal ["true_mail@example.com"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match @user.login, mail.body.encoded
    assert_match @user.activation_token, mail.body.encoded
    assert_match CGI.escape(@user.email), mail.body.encoded
  end
end
