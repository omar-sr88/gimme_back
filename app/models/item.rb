class Item < ApplicationRecord
 
	belongs_to :owner,  :class_name => "User" , foreign_key: "owner_id"
    belongs_to :recipient, :class_name => "User" , foreign_key: "recipient_id"
    validates  :name, presence: true, length: { maximum: 30 }
    validates  :date_lended, presence: true
    validates  :initial_return_date, presence: true
    validate   :is_range_ok?

    scope :open, -> { where(returned: false) }
	scope :closed, -> { where(returned: true) }

	attr_accessor :days_left
	attr_accessor :progress
	attr_accessor :progress_message
	attr_accessor :progress_status
	attr_accessor :guest_recipient
	attr_accessor :recipient_email
	attr_accessor :is_guest

	def Item.set_progress(user,flag)
		case flag
		when 'mine'
		  items = user.owned_items.open
		when 'others'
		  items = user.received_items.open
		when 'done'
		  items = Item.where(owner_id: user.id).closed
		else
  		  items = Item.all.open
		end

		items.each do |item|
		  	total = item.days_to_return(item.date_lended, item.initial_return_date) 
			item.days_left = item.days_to_return(Time.now, item.initial_return_date)

			if item.days_left > 0
			  item.progress = (total - item.days_left)*100/total unless total == 0
			else
			  item.progress = 100
			end

			if item.days_left < 0 
	          item.progress_status = "progress-bar-danger"
	          item.progress_message = "Xi jão, te deram o guela!"
	        elsif item.days_left == 0
	          item.progress_status = "progress-bar-warning"
	          item.progress_message = "É Hoje! Vai atrás mermão!"
	        else
	          item.progress_status = "progress-bar-success"
	          item.progress_message = "Faltam #{item.days_left} dias"
	        end	
		end

		#items.sort_by(&:days_left)
	end

	def is_range_ok?
	    if date_lended.to_s > initial_return_date.to_s
	      errors.add(:initial_return_date, 'must be before lended')
	    end
	    if date_lended.to_s > Date.current.to_s
	      errors.add(:date_lended, 'must be in the past')
	    end
    end

    def is_owned_by?(user)
      self.owner_id == user.id	
    end


	def days_to_return(date1, date2)
  	  (date2.to_date - date1.to_date).to_i
	end


	def Item.prepare_for_save(item_params,owner)
	  @item = Item.new(item_params)
	  @item.owner_id = owner.id
	  if item_params[:is_guest] == "1"
		unless item_params[:guest_recipient].blank?
		  guest = GuestUser.new(name: item_params[:guest_recipient], email: nil , password:"gimmebackdefault")
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
