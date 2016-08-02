class AddDateColumnsToItem < ActiveRecord::Migration[5.0]
  def change
  	 add_column :items, :initial_return_date, :datetime
  	 add_column :items, :returned_date, :datetime
  end
end
