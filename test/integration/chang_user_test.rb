require "test_helper"

class ChangUserTest < ActiveSupport::TestCase
  include SessionLogIn

  def setup
    log_in_as_new_user
    Post.create(title: "aaaa1",
                body: "AAAAA"*200+"1",
                user_id: 1)
    Comment.create(body: "some text",
                   user_id: 1,
                   post_id: 1)
    visit '/users/1/edit'
  end

  def test_edit_email
    find("#user_email").set("new_email@exemple.com")
    find("#user_password").set("True0pass")
    find("#user_password_confirmation").set("True0pass")
    click_on "Update"
    sleep(3)
    assert_equal 1, User.all.count
    assert page.has_content?("new_email@exemple.com")
    assert_equal "new_email@exemple.com", User.all[0].email
  end

  def test_edit_email_by_invalid_email
    find("#user_email").set("invalid-exemple.com")
    find("#user_password").set("True0pass")
    find("#user_password_confirmation").set("True0pass")
    click_on "Update"
    sleep(3)
    assert_not_equal "invalid-exemple.com", User.all[0].email
  end

  def test_edit_password
    find("#user_password").set("Somepass1")
    find("#user_password_confirmation").set("Somepass1")
    click_on "Update"
    sleep(3)
    assert_equal 1, User.all.count
    assert_equal @user.email, User.all[0].email
    assert BCrypt::Password.new(User.all[0].password_digest).is_password?("Somepass1")
  end

  def test_delete
    assert_equal 1, User.all.count
    assert_equal 1, Post.all.count
    assert_equal 1, Comment.all.count
    within(".user-edit") { click_on "Delete account" }
    within("#tab2") do
      find("#user_password").set("True0pass")
      click_on "Delete"
    end
    sleep(3)
    assert_equal 0, User.all.count
    assert_equal 0, Post.all.count
    assert_equal 0, Comment.all.count
  end

  def test_delete_by_wrong_pass
    assert_equal 1, User.all.count
    within(".user-edit") { click_on "Delete account" }
    within("#tab2") do
      find("#user_password").set("Wrong-pass")
      click_on "Delete"
    end
    sleep(3)
    assert_equal 1, User.all.count
  end
end
