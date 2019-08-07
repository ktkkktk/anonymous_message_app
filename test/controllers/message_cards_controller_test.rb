require 'test_helper'

class MessageCardsControllerTest < ActionDispatch::IntegrationTest
  test "should send a message to valid user" do
    user_sent_to = users(:tanaka)
    post message_cards_path, params: { message_card: {content: "Good morning", user_id: user_sent_to.id }}
    assert_redirected_to root_url
    assert_not flash[:success].empty?
  end
  
  test "should not save an empty message" do
    user_sent_to = users(:tanaka)
    post message_cards_path, params: { message_card: {content: "", user_id: user_sent_to.id }}
    assert_template 'users/show'
    assert_not flash[:error].empty?
  end
  
  test "should not send a message to invalid user" do
    post message_cards_path, params: { message_card: {content: "Good evening", user_id: "#{User.count + 1}" }}
    assert_redirected_to root_url
    assert_not flash[:error].empty?
  end
  
end
