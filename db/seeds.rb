# user
# User.create!(name: "test1", description: "test1のdescription", email: "test1@test.com", password: "password")

# user.todos.create!(title: "Todoテスト投稿", description: "テストdescription", user_id: user.id)

5.times do |t|
  User.create!(name: "User#{t+1}", description: "User#{t+1}のdescription", email: "User#{t+1}@test.com", password: "password")
end



# todos
# Todo.create!(title: "Todoテスト投稿", description: "テストdescription", user_id: 1)

user = User.find(1)
# user.todos.create!(title: "Todoテスト投稿", description: "テストdescription", user_id: user.id)
10.times do |t|
    user.todos.create!(title: "#{t+1}Todoテスト投稿", description: "#{t+1}Tテストdescription", user_id: user.id)
end

# users = User.order(:created_at).take(5)
# 10.times do
#   users.each do |user|
#     user.todos.create!(title: "Todoテスト投稿", description: "テストdescription", user_id: user.id)
#   end
# end


