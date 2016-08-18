class CreateUserInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :user_infos do |t|
      t.string :phone_number
      t.string :contact_email
      t.string :address
      t.timestamps
    end
  end
end
