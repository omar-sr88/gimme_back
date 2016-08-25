class Item < ApplicationRecord
 
	belongs_to :owner,  :class_name => "User" , foreign_key: "owner_id"
    belongs_to :recipient, :class_name => "User" , foreign_key: "recipient_id"
    validates  :name, presence: true, length: { maximum: 30 }
    validates  :date_lended, presence: true
    validates  :initial_return_date, presence: true
    validate   :is_range_ok?

    after_update :crop_image

	attr_accessor :image
    mount_uploader :image , ImageUploader

    # has_attached_file :image, styles: { large: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  	# validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  	# validates_attachment_file_name :image, matches: [/png\z/, /jpe?g\z/, /gif\z/]


    scope :open, -> { where(returned: false) }
	scope :closed, -> { where(returned: true) }

	
	#attr_accessor :days_left, :progress, :progress_message,  :progress_status
	attr_accessor :guest_recipient,:recipient_email,:is_guest,:guest_phone, :guest_address,:guest_email
	
	attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


	def Item.all_with_flag(user,flag)
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

		decorators = ItemDecorator.build_collection(items)

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

    def Item.are_users_related?(current, to_display)
    	Item.where(owner_id: current, recipient_id: to_display).or(Item.where(owner_id: to_display ,recipient_id: current)).pluck(:id).length > 0
    end


	

	def crop_image
		image.recreate_versions! if crop_x.present?	
	end



	def Item.prepare_for_save(item_params,owner)
	  @item = Item.new(item_params)
	  @item.owner_id = owner.id
	  if item_params[:is_guest] == "1"
		unless item_params[:guest_recipient].blank?
		  guest = GuestUser.new(name: item_params[:guest_recipient], email: nil , password:"gimmebackdefault")
		  guest.save  
		  uf = UserInfo.new(phone_number: item_params[:guest_phone], contact_email: item_params[:guest_email], address: item_params[:guest_address], user_id: guest.id)
		  uf.save
		  @item.recipient_id = guest.id
		  byebug
		else
		   @item.errors.add(:recipient,"Guest Recipient needs a name")
		end
	  elsif  item_params[:is_guest] == "0"
	  	
	  	if r = User.find_by(nick: item_params[:recipient_email])
 		  @item.recipient_id = r.id
 		else
 		   @item.errors.add(:recipient,"Recipient email not found!")
	  	end
	  end
	  @item
	end
end
