class AddConversationToMessages < ActiveRecord::Migration[7.0]
  def change
    add_reference :messages, :conversation, null: false, foreign_key: true
  end
end
