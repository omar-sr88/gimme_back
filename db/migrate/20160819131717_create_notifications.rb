class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message
      t.boolean :seen , :default => false
      t.references :sender, foreign_key: true
      t.references :to, foreign_key: true

      t.timestamps
      add_index :notifications, [:sender_id, :created_at]
      add_index :notifications, [:to_id, :created_at]
    end
  end
end
