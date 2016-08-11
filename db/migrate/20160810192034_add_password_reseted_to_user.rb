class AddPasswordResetedToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :updated_since_sent, :boolean , default: false
  end
end
