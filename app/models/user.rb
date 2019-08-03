class User < ApplicationRecord
  has_many :message_cards, dependent: :destroy
  has_secure_password
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def send_card_by_email
    UserMailer.message_card(self).deliver_now
  end
end
