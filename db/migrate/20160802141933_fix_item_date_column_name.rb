class FixItemDateColumnName < ActiveRecord::Migration[5.0]
  def change
  	 rename_column :items, :date, :date_lended
  end
end
