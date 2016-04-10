# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


100.times do
  ActiveRecord::Base.transaction do
    password = Faker::Internet.password
    user_name = Faker::Internet.user_name
    email = "#{user_name}@gmail.com"
    user = User.create!(user_name: user_name, email: email, password: password, password_confirmation: password)
    20.times do
      user.messages.create!(content: Faker::Lorem.characters(Random.rand(20..159)), created_at: Faker::Time.between(DateTime.now - 100, DateTime.now))
    end
  end
end
