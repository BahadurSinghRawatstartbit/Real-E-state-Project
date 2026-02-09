class AddConversationAndSenderToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :conversation, foreign_key: true
    add_reference :messages, :sender, foreign_key: { to_table: :users }
  end
end
