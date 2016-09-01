FactoryGirl.define do 
  factory :user , aliases: [:owner, :recipient] do 
	sequence(:name) { |i| "User Name#{i}"}
	sequence(:email) { |i| "test#{i}@email.com"}
	sequence(:nick) { |i| "exam#{i}"}
	#sequence(:id) { |i| i }
  	password_digest User.digest('omar123')
	activated true
	activated_at Time.zone.now 
  end

  factory :guest, class: GuestUser, parent: :user do
  	sequence(:name) { |i| "Guest Name#{i}"}
  	sequence(:email) { |i| "guest#{i}@email.com"}
  end
end