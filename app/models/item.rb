class Item < ApplicationRecord
 
	belongs_to :user, :class_name => "User"
    belongs_to :recipient, :class_name => "User"

	attr_accessor :days_left
	attr_accessor :progress


	def self.all_with_progress
		items = Item.all

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
