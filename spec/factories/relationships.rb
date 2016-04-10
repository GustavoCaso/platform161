FactoryGirl.define do
  factory :relationship do
    follower_id { Random.rand(1..50) }
    followed_id { Random.rand(60..100) }
  end
end
