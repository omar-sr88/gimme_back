class User < ApplicationRecord

  #todo create user soft delete feature
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :owned_items, :class_name => 'Item', :foreign_key =>  :owner_id
  has_many :received_items, :class_name => 'Item', :foreign_key => :recipient_id
  has_one :info, :class_name => 'UserInfo' , :foreign_key =>  :user_id
  accepts_nested_attributes_for :info

  has_many :sent_notifications, :class_name => 'Notification', :foreign_key =>  :sender_id
  has_many :received_notifications, :class_name => 'Notification', :foreign_key => :to_id


	before_save :downcase_email if  self.class.name == 'User'
	before_create :create_activation_digest
	validates :name, presence: true , length: { maximum: 50 }

  validates :nick, presence: true , length: { minimum: 4 , maximum: 15 }

	validates :email, presence: true,
                    allow_blank: false , 
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 50 }  if :user_type
	validates :email,   format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i } if :user_type

	has_secure_password           
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true 


  attr_accessor :messages_unseen

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest") #send to self
  	return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 24.hours.ago
  end

  def set_updated_password
    update_attribute(:updated_since_sent, true)
  end

  def self.search(search)
    @users = select('name, nick').where('nick LIKE ?', "#{search}%")
  end

  def self.username_available(username)
    User.where(nick: username).empty?
  end




  private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

    def user_type
      self.class.name == "User"
    end

end
