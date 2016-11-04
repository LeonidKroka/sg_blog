require "test_helper"

class NewUserTest < ActiveSupport::TestCase
  def setup
    visit "/users/new"
    page.execute_script('document.cookie = "lat_lng=" + "50|50";')
  end

  def test_create_new_post_and_press_submit_must_add_new_post
    find("#user_login").set(user_data[:login][:valid])
    find("#user_email").set(user_data[:email][:valid])
    find("#user_password").set(user_data[:pass][:valid])
    find("#user_password_confirmation").set(user_data[:pass][:valid])
    click_on "Registration"
    sleep(3)
    assert_equal 1, User.all.count
  end

  def test_show_error_message_when_post_should_not_be_created
    find("#user_login").set(user_data[:login][:invalid])
    find("#user_email").set(user_data[:email][:invalid])
    find("#user_password").set(user_data[:pass][:valid])
    find("#user_password_confirmation").set(user_data[:pass][:valid])
    click_on "Registration"
    assert page.has_content?(error_message)
  end

  private
    def user_data
      {:login => {:valid => "True_login",
                  :invalid => "Fail-login"},
       :email => {:valid => "some@exemple.dom",
                  :invalid => "Short text"},
       :pass => {:valid => "Aaaaa1",
                 :invalid => "aaaaaa"}}
    end

    def error_message
      "Sorry, your data is not valid. Please, try again."
    end
end
