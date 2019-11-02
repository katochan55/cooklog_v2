# ユーザー
User.create!(name:  "山田 太郎",
             email: "sample@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# 料理
10.times do |n|
  Dish.create!(name: Faker::Food.dish,
               description: "冬に食べたくなる、身体が温まる料理です",
               portion: 1.5,
               tips: "ピリッと辛めに味付けするのがオススメ",
               reference: "https://cookpad.com/recipe/2798655",
               required_time: 30,
               popularity: 5,
               cook_memo: "初めて作った割にはうまくできた！",
               user_id: 1)
  dish = Dish.first
  Log.create!(dish_id: dish.id,
              content: dish.cook_memo)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
