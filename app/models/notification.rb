class Notification < ApplicationRecord
  belongs_to :sender,  :class_name => "User" , foreign_key: "sender_id"
  belongs_to :to, :class_name => "User" , foreign_key: "to_id"

  scope :seen, -> { where(seen: true) }
  scope :unseen, -> { where(seen: false) }

  #from , #to
  @@messages = {:create => "%s, user %s lended you a new item : %s!", :ret => "%s, user %s got his item back: %s"}
  @@titles = {:create => "New Item Lended!", :ret => "Item Returned!"}


  def Notification.send_notification(item , type)
  	message = @@messages[type] %  [item.recipient.name , item.owner.name , item.name]
  	n = Notification.new(title:  @@titles[type], message: message, sender: item.owner, to: item.recipient)
  	n.save
  end
end
