# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create first admin user
email = "demo@demo.com"
password = "password"

User.create(email: email, password: password, password_confirmation: password)

# Creating Remaining Users
40.times do
  email = Faker::Internet.email
  password = "password"

  User.create(email: email, password: password, password_confirmation: password)
end

# Create some tweets
200.times do
  tweet_body = Faker::HarryPotter.quote
  offset = rand(User.count)
  user_id = User.offset(offset).limit(1).first.id

  Tweet.create(body: tweet_body, user_id: user_id)
end

# Create some messages
100.times do
  msg_body = Faker::HarryPotter.quote
  offset = rand(User.count)
  from_user_id = User.offset(offset).limit(1).first.id
  to_user_id=User.offset(offset).limit(1).first

  Message.create(from_user_id: from_user_id,
      to_user_id: to_user_id, body: msg_body)
end


# Link Users together
500.times do
  offset = rand(User.count)
  follower = User.offset(offset).limit(1).first
  offset = rand(User.count)
  followed = User.offset(offset).limit(1).first

  while follower.following.exists?(:id => followed.id)
    offset = rand(User.count)
    followed = User.offset(offset).limit(1).first
  end
    Following.create(follower_id: follower.id, followed_id: followed.id)
end