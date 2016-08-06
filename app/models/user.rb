class User < ApplicationRecord

	has_many :items

	before_save { self.email = email.downcase }
	validates :name, presence: true , length: { maximum: 50 }
	validates :email, presence: true, uniqueness: { case_sensitive: false } , length: { maximum: 50 }, 
	           format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }   
	            
	has_secure_password              
	validates :password, presence: true, length: { minimum: 6 }
end
