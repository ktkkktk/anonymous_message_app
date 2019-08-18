require 'test_helper'

class SendingCardTest < ActionDispatch::IntegrationTest
  def setup
    UserMailer.deliveries.clear  
  end
  
  test "Submitting a card successfully" do
    user_sent_to = users(:tanaka)
    content = "こんにちは。\n お元気ですか？\nいつも応援しています。"
    get user_path(user_sent_to)
    assert_difference 'user_sent_to.message_cards.count', 1 do
      post message_cards_path, params: { message_card: { content: content, user_id: user_sent_to.id}}
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    sent_message = assigns(:message_card)
    assert_not flash[:success].empty?
    assert_redirected_to root_url
    follow_redirect!
    log_in_as(user_sent_to, "password")
    follow_redirect!
    assert_template 'users/show'
    assert_match  content, response.body
    assert_select 'a[href=?]', message_card_path(sent_message)
    assert_select 'a[data-method=delete][href=?]', message_card_path(sent_message)
    get message_card_path(sent_message), xhr: true
    assert_template 'message_cards/show'
  end
  
  test "Submitting a card without content" do
    user_sent_to = users(:tanaka)
    assert_no_difference 'user_sent_to.message_cards.count', 0 do
      post message_cards_path, params: { message_card: { content: '', user_id: user_sent_to.id}}
    end
    assert_template 'users/show'
    assert_not flash[:danger].empty?
  end
  
end
