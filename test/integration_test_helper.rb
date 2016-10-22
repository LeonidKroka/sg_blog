class ActiveSupport::TestCase
  include Capybara::DSL
  Capybara.use_default_driver
  self.use_transactional_fixtures = false
  DatabaseCleaner[:active_record].strategy = :truncation

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
end

class Integrations < ActionDispatch::IntegrationTest
  include Capybara::DSL
  self.use_transactional_fixtures = false
  Capybara.default_driver = :webkit
  Capybara.javascript_driver = :webkit
  Capybara.ignore_hidden_elements = true
  DatabaseCleaner.strategy = :truncation

  setup do
    DatabaseCleaner.clean
  end

  teardown do
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end


def setup
  Post.create(title: "aaaa1", body: "A"*200)
end

def test_create_new_valid_comment
  post post_comments_path(post_id: 1), xhr: true,
                                       :comment => {body: "Some short text"},
                                       format: :js
  assert_equal 1, Post.all[0].comments.count
end

def test_can_not_create_invalid_comment
  post post_comments_path(post_id: 1), xhr: true,
                                       :comment => {body: "a"*201},
                                       format: :js
  assert_equal 0, Post.all[0].comments.count
end

def test_create_new_valid_comment
  visit post_path(id: 1)
  find("#comment_body").set("Something")
  click_on "It's ok!"
  assert page.has_content? ("Something")
end

def test_invalid_coment_form_should_have_error_message_and_red_border
  visit post_path(id: 1)
  find("#comment_body").set("a"*201)
  click_on "It's ok!"
  within("div.alert-errors") { assert page.has_content? ("is too long") }
  assert page.find_by_id('comment_body')[:style].include?('red')
end

def test_invalid_coment_edit_form_should_have_error_message_and_red_border
  Post.all[0].comments.create(:body => "valid")
  visit post_path(id: 1)
  within("div.comments") { click_on "Edit" }
  within("div.comment-edit-forms") do
    find("#comment_body").set("a"*201)
    click_on "Now ok!"
    assert page.has_content? ("is too long")
    assert page.find_by_id('comment_body')[:style].include?('red')
  end
end

def test_valid_coment_edit_should_update_comment_and_hide_comment_edit_form
  Post.all[0].comments.create(:body => "valid")
  visit post_path(id: 1)
  within("div.comments") { click_on "Edit" }
  within("div.comment-edit-forms") do
    find("#comment_body").set("Something")
    click_on "Now ok!"
  end
  within("div.comments") { assert page.has_content? ("Something") }
  assert_equal 0, page.all(".comment-edit-forms").count
end

def test_one_page_show_only_ten_comments
  11.times {|n| Post.all[0].comments.create(:body => "valid_#{n}")}
  visit "/posts/1"
  assert_equal 10, page.all(".list-group-item").count
  assert_equal 2, (page.all(".pagination li").count-4)/2
end
