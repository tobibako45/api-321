# ユーザー
# User.create!(name: "user1", description: "user1のdescription", email: "user1@example.com", password: "password")

5.times do |t|
  User.create!(name: "user#{t+1}", description: "user#{t+1}のdescription", email: "user#{t+1}@example.com", password: "password")
end

# タスク
# Todo.create!(title: "todoテスト投稿", description: "テストdescription", user_id: 1)
user = User.find(1)
# user.todos.create!(title: "todoテスト投稿", description: "テストdescription", user_id: user.id)
10.times do |t|
    user.todos.create!(title: "#{t+1}todoテスト投稿", description: "#{t+1}todoテストdescription", user_id: user.id)
end

# users = User.order(:created_at).take(5)
# 10.times do
#   users.each do |user|
#     user.todos.create!(title: "todoテスト投稿", description: "テストdescription", user_id: user.id)
#   end
# end