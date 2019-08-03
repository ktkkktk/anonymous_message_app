class UserMailer < ApplicationMailer

  def message_card(user)
    @content = user.message_cards.last.content
    mail to: user.email, subject: "メッセージカードが届きました！"
  end
end
