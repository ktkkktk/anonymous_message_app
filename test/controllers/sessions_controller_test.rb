require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login with valid account" do
    user = users(:tanaka)
    post login_path, params: { session: {email: user.email, password: "password"} }
    assert is_logged_in?
    assert_redirected_to user_path(user)
    follow_redirect!
    assert_template 'users/show'
  end
  
  test "login with not-existing account" do
    post login_path, params: { session: { email: "NotExisting@email.com", password: "password"}}
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end
  
  test "login with wrong password" do
    user = users(:tanaka)
    post login_path, params: { session: { email: user.email, password: "wrong password"}}
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
    assert_not flash.empty?
  end
  
  test "logout" do
    log_in_as(users(:tanaka), "password")
    assert is_logged_in?
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end
end
