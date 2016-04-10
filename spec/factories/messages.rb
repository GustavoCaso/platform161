FactoryGirl.define do
  factory :message do
    content { 'what ever it pop in my head' }
    association :user, factory: [:user, :with_password]
  end
end
