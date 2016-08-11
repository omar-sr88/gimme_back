class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.datetime :date
      t.references :owner, foreign_key: true
      t.references :recipient, foreign_key: true

      t.timestamps
    end
    #add index for the ownner and recipient
    add_index :items, [:owner_id, :created_at]
    add_index :items, [:recipient_id, :created_at]
  end
end
