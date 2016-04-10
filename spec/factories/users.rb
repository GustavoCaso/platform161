FactoryGirl.define do
  factory :user do
    sequence(:user_name) { |n| "JohnDoe#{n}" }
    sequence(:email) { |n| "jonhndoe#{n}@email.com" }

    trait :with_password do
      password 'valid_one'
      password_confirmation 'valid_one'
    end
  end
end
