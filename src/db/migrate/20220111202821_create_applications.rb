class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications, id: false do |t|
      t.string :name
      t.string :token, primary_key: true, null: false
      t.integer :chats_count, default: 0

      t.timestamps
    end
    add_index :applications, :token
  end
end
