class Item < ApplicationRecord
 
	belongs_to :owner,  :class_name => "User"
    belongs_to :recipient, :class_name => "User"
    validates  :owner_id, :recipient_id, presence: true
    validates  :name, presence: true, length: { maximum: 30 }


	attr_accessor :days_left
	attr_accessor :progress
	attr_accessor :returned
	attr_accessor :guest_recipient
	


	def Item.set_progress(user,flag)
		case flag
		when 'mine'
		  items = user.owned_items
		when 'others'
		  items = user.received_items
		else
  		  items = Item.all
		end

		items.each do |item|
			total = item.days_to_return(item.date_lended, item.initial_return_date) 
			item.days_left = item.days_to_return(Time.now, item.initial_return_date)

			if item.days_left > 0
				item.progress = (total - item.days_left)*100/total unless total == 0
			else
				item.progress = 100
			end
		end
		#items.sort_by(&:days_left)
	end

	def days_to_return(date1, date2)
  	  (date2.to_date - date1.to_date).to_i
	end

end
