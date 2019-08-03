class AddUserIdToMessageCard < ActiveRecord::Migration[5.2]
  def change
    add_column :message_cards, :user_id, :integer
    add_index :message_cards, [:user_id, :created_at]
  end
end
