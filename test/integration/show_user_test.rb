require "test_helper"

class ShowUserTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create( login: "True_login",
                         email: "true_mail@example.com",
                         password: "True0pass",
                         password_confirmation: "True0pass",
                         latitude: "50",
                         longitude: "50")
    visit "/users/1"
  end

  def test_show_page_must_have_users_statistics_and_email
    assert page.has_content?("True_login")
    assert_equal 1, page.all('div.user-info-data').count
    assert page.has_content?("true_mail@example.com")
  end

  def test_show_page_when_user_create_post
    @user.posts.create(title: "aaaaa", body: "A"*200)
    visit "/users/1"
    assert page.has_content?("1 post")
    assert page.has_content?("aaaaa")
  end
end
