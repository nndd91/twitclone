# This will guess the User class
FactoryGirl.define do
	factory :tweet do
		association :user, factory: :user
		body "Test"
	end
end