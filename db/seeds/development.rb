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

# 料理
dish_name_1 = "季節の野菜と豚肉を使った野菜炒め"
dish_name_2 = "かに玉"
description = "冬に食べたくなる、身体が温まる料理です"
portion = 2
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


#
# 6.times do |n|
#   Dish.create!(
#     [
#       {
#         name: "その他食べ物",
#         user_id: 1,
#         description: description,
#         portion: portion,
#         tips: tips,
#         reference: reference,
#         required_time: required_time,
#         popularity: popularity,
#         cook_memo: cook_memo,
#         ingredients_attributes: ingredients_attributes,
#       },
#       {
#         name: "その他食べ物",
#         user_id: 2,
#         description: description,
#         portion: portion,
#         tips: tips,
#         reference: reference,
#         required_time: required_time,
#         popularity: popularity,
#         cook_memo: cook_memo,
#         ingredients_attributes: ingredients_attributes,
#       }
#     ]
#   )
# end

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
        picture: open("#{Rails.root}/public/images/dish1.jpg"),
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
        picture: open("#{Rails.root}/public/images/dish2.jpg"),
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
        picture: open("#{Rails.root}/public/images/dish1.jpg"),
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
        picture: open("#{Rails.root}/public/images/dish2.jpg"),
        ingredients_attributes: ingredients_attributes,
      }
    ]
  )
end
