class Item < ApplicationRecord
 
	belongs_to :owner,  :class_name => "User" , foreign_key: "owner_id"
    belongs_to :recipient, :class_name => "User" , foreign_key: "recipient_id"
    validates  :name, presence: true, length: { maximum: 30 }
    validates  :date_lended, presence: true
    validates  :initial_return_date, presence: true

    validate   :is_range_ok?

	attr_accessor :days_left
	attr_accessor :progress
	attr_accessor :returned
	attr_accessor :guest_recipient
	attr_accessor :recipient_email
	attr_accessor :is_guest

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

	def is_range_ok?
		byebug
	    if date_lended.to_s > initial_return_date.to_s
	      errors.add(:initial_return_date, 'must be before lended')
	    end
	    if date_lended.to_s > Date.current.to_s
	      errors.add(:date_lended, 'must be in the past')
	    end
    end



	def days_to_return(date1, date2)
  	  (date2.to_date - date1.to_date).to_i
	end


	def Item.prepare_for_save(item_params,owner)
	  @item = Item.new(item_params)
	  @item.owner_id = owner.id
	  if item_params[:is_guest] == "1"
		unless item_params[:guest_recipient].blank?
		  guest = GuestUser.new(name: item_params[:guest_recipient], email: "xxxx@xxxx.com:friend:"+owner.id.to_s, password:"gimmebackdefault")
		  guest.save  
		  @item.recipient_id = guest.id
		else
		   @item.errors.add(:recipient,"Guest Recipient needs a name")
		end
	  elsif  item_params[:is_guest] == "0"
	  	
	  	if r = User.find_by(email: item_params[:recipient_email])
 		  @item.recipient_id = r.id
 		else
 		   @item.errors.add(:recipient,"Recipient email not found!")
	  	end
	  end
	  @item
	end
end
