class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.bigint :chat_id
      t.integer :message_number, default: 0
      t.text :body

      t.timestamps
    end
  end
end
