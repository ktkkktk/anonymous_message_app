require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "message_card" do
    user = users(:tanaka)
    content = message_cards(:hello).content
    user.message_cards.create(content: content)
    mail = UserMailer.message_card(user)
    assert_equal "メッセージカードが届きました！", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@anonymous-message-cards.com"], mail.from
  end
end
