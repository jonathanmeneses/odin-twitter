# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
jonathan = User.create!(    username: 'jmeatx',
name: 'Jonathan Meneses',
email: 'jonathan@gmail.com',
password: 'password',
created_at: Faker::Time.between(from: '2024-04-01', to: Date.today))

users = 10.times.map do
  User.create!(
    username: Faker::Internet.username,
    name: Faker::Internet.name,
    email: Faker::Internet.email,
    password: 'password',
    created_at: Faker::Time.between(from: '2024-04-01', to: Date.today)
  )
end

users << jonathan

users.each do |user|
  rand(2..5).times do
    user.posts.create!(
      content: Faker::Lorem.paragraph(sentence_count: 2),
      created_at: Faker::Time.between(from: user.created_at, to: Date.today)
    )
  end

  users_to_follow = users.reject { |u| u == user }.sample(rand(5..7)).uniq
  users_to_follow.each do |followed_user|
    user.following << followed_user unless user.following.include?(followed_user)
  end
  user.following << jonathan unless (user.following.include?(jonathan) || user == jonathan)
end


all_posts = Post.all
users.each do |user|
  # ... previous code ...

  # Comment on 20 random posts
  all_posts.sample(20).each do |post|
    time_to_use = Faker::Time.between(from: user.created_at, to: Date.today)
    post.comments.create!(
      user: user,
      content: Faker::Lorem.sentence(word_count: 10),
      created_at: time_to_use,
      updated_at: time_to_use)
  end

  # Like 50% of total posts
  all_posts.sample(all_posts.size / 2).each do |post|
    post.likes.create!(user: user)
  end
end
