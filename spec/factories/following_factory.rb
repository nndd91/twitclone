# This will guess the User class
FactoryGirl.define do
  factory :following do
  	association :follower, factory: :user
  	association :followed, factory: :user
  	
  end
end