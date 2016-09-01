FactoryGirl.define do 
  factory :item do 
	sequence(:name) { |i| "Livro Magic#{i}"}
	sequence(:description) { |i| "Test item#{i}"}
	date_lended "11/01/2014 13:23"
	initial_return_date "12/01/2014"

	association :owner
	association :recipient
  end
end