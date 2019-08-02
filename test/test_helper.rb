ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def log_in_as(user, password)
     post login_path, params: { session: { email: user.email, password: password}}
  end
  
  def is_logged_in?
    !session[:user_id].nil?
  end
  
end
