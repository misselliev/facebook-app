
emails = %w(eli@woof.com santiago@woof.com dulce@woof.com lulu@woof.com)

# Creating users
4.times do |i|
  date_time = Faker::Time.between_dates(from: 3.years.ago - 1, to: Date.today, period: :all)
  user = User.create!(name: Faker::Name.unique.first_name,
                     lastname: Faker::Name.last_name,
                     email: emails[i],
                     password: '123456',
                     password_confirmation: '123456',
                      created_at: date_time,
                      updated_at: date_time)

# Creating posts
  5.times do
    date_time = Faker::Time.between_dates(from: 3.months.ago - 1, to: Date.today, period: :all)
    user.posts.build(
      content: Faker::Hacker.say_something_smart,
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

user1.friendships.build(friend_id: user2.id, confirmed: true).save
user1.friendships.build(friend_id: user3.id, confirmed: false).save
user1.friendships.build(friend_id: user4.id).save

# Creating comments
30.times do |i|
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
30.times do |i|
  user = User.all.sample
  post = Post.all.sample
  user.likes.build(
    post: post,
  ).save
end