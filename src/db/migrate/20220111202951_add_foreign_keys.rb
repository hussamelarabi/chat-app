class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :chats, :applications, column: :app_token, primary_key: :token,  on_delete: :cascade
    add_foreign_key :messages, :chats, column: :chat_id, primary_key: :id,  on_delete: :cascade
  end
end
