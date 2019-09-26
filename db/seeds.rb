# frozen_string_literal: true

emails = %w[eli@woof.com santiago@woof.com dulce@woof.com lulu@woof.com stanley@woof.com]

# Creating users
5.times do |i|
  date_time = Faker::Time.between_dates(from: 3.years.ago - 1, to: Date.today, period: :all)
  user = User.create!(name: Faker::Name.unique.first_name,
                      lastname: Faker::Name.last_name,
                      email: emails[i],
                      password: '123456',
                      password_confirmation: '123456',
                      created_at: date_time,
                      updated_at: date_time)

  # Creating posts
  3.times do
    date_time = Faker::Time.between_dates(from: 3.months.ago - 1, to: Date.today, period: :all)
    user.posts.build(
      content: Faker::Hacker.say_something_smart,
      friend_id: user,
      created_at: date_time,
      updated_at: date_time
    ).save
  end

  2.times do
    friend = Array(0..4).sample
    date_time = Faker::Time.between_dates(from: 3.months.ago - 1, to: Date.today, period: :all)
    user.posts.build(
        content: Faker::Hacker.say_something_smart,
        friend_id: friend,
        created_at: date_time,
        updated_at: date_time
    ).save
  end
end

# Creating friendships
user1 = User.first
user2 = User.second
user3 = User.third
user4 = User.fourth
user5 = User.fifth

f = Friendship.create(user: user1, friend: user2)
Friendship.confirm_friendship(f)                  # Confirmed
f = Friendship.create(user: user1, friend: user3)
Friendship.confirm_friendship(f)                  # Confirmed
f = Friendship.create(user: user1, friend: user4) # Pending
f = Friendship.create(user: user1, friend: user5) # Pending
f = Friendship.create(user: user4, friend: user2) # Pending
f = Friendship.create(user: user5, friend: user2) # Pending

# Creating comments
30.times do |_i|
  date_time = Faker::Time.between_dates(from: 3.months.ago - 1, to: Date.today, period: :all)
  user = User.all.sample
  post = Post.all.sample
  post.comments.build(
    content: Faker::Movie.quote,
    commenter: user,
    created_at: date_time,
    updated_at: date_time
  ).save
end

# Creating likes
30.times do |_i|
  user = User.all.sample
  post = Post.all.sample
  user.likes.build(
    post: post
  ).save
end
