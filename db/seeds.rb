# ユーザー
User.create!(
  [
    {
      name:  "PersonA",
      email: "pa@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "PersonB",
      email: "pb@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
    }
  ]
)

98.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n + 1}@example.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# 料理
dish_name_1 = "季節の野菜と豚肉を使った野菜炒め"
dish_name_2 = "かに玉"
description = "冬に食べたくなる、身体が温まる料理です"
portion = 1.5
tips = "ピリッと辛めに味付けするのがオススメ"
reference = "https://cookpad.com/recipe/2798655"
required_time = 30
popularity = 5
cook_memo = "初めて作った割にはうまくできた！"
ing_name = "じゃがいも"
ing_quantity = "2個"
ingredients_attributes = [
                          { name: ing_name, quantity: ing_quantity },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" },
                          { name: "", quantity: "" }
                        ]

6.times do |n|
  Dish.create!(
    [
      {
        name: Faker::Food.dish,
        user_id: 1,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      },
      {
        name: Faker::Food.dish,
        user_id: 2,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      }
    ]
  )
end

2.times do |n|
  Dish.create!(
    [
      {
        name: dish_name_1,
        user_id: 1,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      },
      {
        name: dish_name_2,
        user_id: 1,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      },
      {
        name: dish_name_1,
        user_id: 2,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      },
      {
        name: dish_name_2,
        user_id: 2,
        description: description,
        portion: portion,
        tips: tips,
        reference: reference,
        required_time: required_time,
        popularity: popularity,
        cook_memo: cook_memo,
        ingredients_attributes: ingredients_attributes,
      }
    ]
  )
end

# ログ
Dish.all.each do |dish|
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
