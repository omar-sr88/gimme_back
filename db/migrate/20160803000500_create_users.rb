class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :nick
      t.boolean :super , :default => false

      t.timestamps
    end
  end
end
