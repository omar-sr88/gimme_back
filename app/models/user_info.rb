class UserInfo < ApplicationRecord
	has_one :user, :class_name => "User" , foreign_key: "user_id"
end
