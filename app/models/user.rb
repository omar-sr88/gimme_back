class User < ApplicationRecord

	attr_accessor :remember_token, :activation_token
	has_many :items
	before_save :downcase_email #{ self.email = email.downcase }
	before_create :create_activation_digest
	validates :name, presence: true , length: { maximum: 50 }
	validates :email, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 50 }, 
	           format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }   
	            
	has_secure_password              
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true


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


end
