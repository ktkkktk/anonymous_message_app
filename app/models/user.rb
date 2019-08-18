class User < ApplicationRecord
  has_many :message_cards, dependent: :destroy
  has_secure_password
  
  
  validates :email, presence: true, length: {maximum: 50}
  
  attr_accessor :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def send_card_by_email
    UserMailer.message_card(self).deliver_now
  end
  
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def authenticated?(activation_token)
    return false if self.activation_digest.nil?
    BCrypt::Password.new(activation_digest).is_password?(activation_token)
  end
  
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
  
  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
    def downcase_email
      self.email.downcase!
    end
end
