class Notification < ApplicationRecord
  belongs_to :sender,  :class_name => "User" , foreign_key: "sender_id"
  belongs_to :to, :class_name => "User" , foreign_key: "to_id"
end
