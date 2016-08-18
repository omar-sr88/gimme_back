class AddColumnToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :returned, :boolean , :default => false
  end
end
