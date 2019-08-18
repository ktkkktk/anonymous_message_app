require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "valid signup with account activation" do
    get root_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { email: "example@test.com",
                                         password: "password",
                                         password_confirmation: "password"} }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # try log-in with non activated user
    # log_in_as(user)
    # assert_not is_logged_in?
    # token is correct but email is wrong
    get edit_account_activation_path(user.activation_token, email: "wrong@email.com")
    assert_not is_logged_in?
    assert_not user.reload.activated?
    # token and email are correct
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  
  test "invalid signup" do
    get root_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "",
                                         password: "password",
                                         password_confirmation: "password"} }
    end
    assert_redirected_to root_url
  end
  
  test "signup with an email already signned up" do 
    user = users(:tanaka)
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: user.email,
                                         password: "password2",
                                         password_confirmation: "password2"} }
    end
    assert_redirected_to root_url
    assert_not flash[:warning].empty?
  end
  
end
