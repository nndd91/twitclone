FactoryGirl.define do
  factory :following do
    association :followed, factory: :user
    association :follower, factory: :user

    trait :invalid do
      followed nil
    end
  end
end
