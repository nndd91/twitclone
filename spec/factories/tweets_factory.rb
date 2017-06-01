FactoryGirl.define do
  factory :tweet do
    body "This is a paragraph about the tweet."
    user

    trait :invalid do
      body nil
    end
  end
end
