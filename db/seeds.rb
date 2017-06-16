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
first_name = "Demo"
last_name = Faker::Name.last_name
username = "Demo"
age = Faker::Number.between(15, 30)
is_admin = true

User.create(email: email, password: password, password_confirmation: password, is_admin: is_admin, first_name: first_name, last_name: last_name, age: age, username: username)

# Creating Remaining Users
40.times do
  username = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  age = Faker::Number.between(15, 30)

  User.create(username: username, email: email, password: password, password_confirmation: password,
              first_name: first_name, last_name: last_name, age: age )
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

#Create some comment in tweets
100.times do
  body = Faker::HarryPotter.quote
  offset = rand(20)
  offset2= rand(User.count)
  from_user_id = User.offset(offset2).limit(1).first

  tweet = Tweet.offset(offset).limit(1).first

  Reply.create(tweet: tweet, body: body, user: from_user_id)
end

# Link Users together

200.times do
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

# Create Likes
200.times do
  offset = rand(Tweet.count)
  tweet = Tweet.offset(offset).limit(1).first
  offset = rand(User.count)
  user = User.offset(offset).limit(1).first

  while tweet.likes.exists?(user_id: user.id)
    offset = rand(User.count)
    user = User.offset(offset).limit(1).first
  end
    Like.create(tweet_id: tweet.id, user_id: user.id)
end
