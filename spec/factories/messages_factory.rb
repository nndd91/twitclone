FactoryGirl.define do
  factory :message do
    association :from_user_id, factory: :user
    association :to_user_id, factory: :user
    body "MyText"

    trait :invalid do
      body nil
    end
  end
end

