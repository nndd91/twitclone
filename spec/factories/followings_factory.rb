FactoryGirl.define do
  factory :following do
    follower_id 1
    followed_id 2

    trait :invalid do
      followed nil
    end
  end
end
