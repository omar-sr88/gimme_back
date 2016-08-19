class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :message

      t.references :sender, foreign_key: true
      t.references :to, foreign_key: true

      t.timestamps
    end
  end
end
