class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :phone_number , :default => ''
      t.string :contact_email , :default => ''
      t.string :address, :default => ''
      t.timestamps
    end
  end
end
