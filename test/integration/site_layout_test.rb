require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "header menu before log-in" do
    get root_path
    assert_select 'a[href=?]', root_path
    ### assert_select 'a[href=?]', user_path(), false
    ### assert_select 'a[href=?]', setting_path(), false
    assert_select 'a[href=?]', logout_path, false
  end
  
  test "header menu after log-in" do
    user = users(:tanaka)
    log_in_as(user, 'password')
    get user_path(user)
    assert_select 'a[href=?]', root_path
    assert_select 'a[href=?]', user_path(user)
    assert_select 'a[href=?]', setting_path(user)
    assert_select 'a[href=?]', logout_path
  end
  
  test "home page before log-in" do
    get root_path
    assert_template "static_pages/home"
    # Check login form
    assert_select 'form input[type=submit]', 1
  end
    
  test "home page after log-in" do
    user = users(:tanaka)
    log_in_as(user, "password")
    assert_redirected_to user_path(user)
    follow_redirect!
    assert_template 'users/show'
  end
  
  test "user page before log-in" do
    user = users(:tanaka)
    get user_path(user)
    assert_template 'users/show'
    assert_select 'textarea'
    assert_select 'form input[type=submit]'
  end
    
  test "user page after log-in" do
    user = users(:tanaka)
    log_in_as(user, 'password')
    get user_path(user)
    assert_template 'users/show'
    
    ######TODO: test for Card objects########
  end
  
  test "setting page before log-in" do
    user = users(:tanaka)
    get setting_path(user)
    assert_redirected_to root_url
  end
  
  test "setting page after log-in" do
    user = users(:tanaka)
    log_in_as(user, 'password')
    get setting_path(user)
    assert_template 'settings/show'
    
    ######TODO: test for Card objects########
  end
  
end
