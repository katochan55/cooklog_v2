# ユーザー
User.create!(
  [
    {
      name:  "山田 良子",
      email: "yamada@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "鈴木 恵子",
      email: "suzuki@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "採用 太郎",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
    },
  ]
)

# フォロー関係
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

# 料理
portion = 2
description1 = "冬に食べたくなる、身体が温まる料理です"
description2 = "栄養バランスが良いオススメ料理です"
description3 = "スピード重視の簡単料理！"
tips1 = "野菜を事前に煮込んで柔らかくしておくと良いです！"
tips2 = "隠し味の胡椒がポイント！"
tips3 = "少し焦げ目をつけると美味しいです！"
cook_memo1 = "初めて作った割にはうまくできた！"
cook_memo2 = "味が薄めだったので、次はもう少し濃い味付けにしよう"
cook_memo3 = "大好評だったので、また作ろう"

## 3ユーザー、それぞれ5料理ずつ作成
Dish.create!(
  [
    {
      name: "肉じゃが",
      user_id: 1,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5905307",
      required_time: 30,
      popularity: 3,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish1.jpg"),
      ingredients_attributes: [
                                { name: "豚ロース肉", quantity: "300g" },
                                { name: "じゃがいも", quantity: "2個" },
                                { name: "にんじん", quantity: "1本" },
                                { name: "玉ねぎ", quantity: "1個" },
                                { name: "しょうゆ", quantity: "大さじ2" },
                                { name: "みりん", quantity: "大さじ2" },
                                { name: "酒", quantity: "大さじ2" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ソーセージと卵の炒め物",
      user_id: 2,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5890533",
      required_time: 20,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish2.jpg"),
      ingredients_attributes: [
                                { name: "ソーセージ", quantity: "4本" },
                                { name: "卵", quantity: "2個" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "かに玉",
      user_id: 3,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5826415",
      required_time: 15,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish3.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "6個" },
                                { name: "かに玉の素", quantity: "1袋" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚こまの生姜焼き",
      user_id: 1,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5892456",
      required_time: 20,
      popularity: 3,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/images/dish4.jpg"),
      ingredients_attributes: [
                                { name: "豚こま切れ肉", quantity: "100g" },
                                { name: "玉ねぎ", quantity: "1個" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "鶏肉のチーズ照り焼き",
      user_id: 2,
      description: description3,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5878179",
      required_time: 40,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/images/dish5.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "100g" },
                                { name: "チーズ", quantity: "3枚" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "タンドリーチキン",
      user_id: 3,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5909869",
      required_time: 30,
      popularity: 3,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/images/dish6.jpg"),
      ingredients_attributes: [
                                { name: "鶏胸肉", quantity: "300g" },
                                { name: "塩", quantity: "少々" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "鶏肉の味噌照り焼き",
      user_id: 1,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5899721",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish7.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "250g" },
                                { name: "味噌", quantity: "大さじ1" },
                                { name: "玉ねぎ", quantity: "0.5個" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚しゃぶレタス",
      user_id: 2,
      description: description2,
      portion: portion,
      tips: tips2,
      reference: "https://cookpad.com/recipe/5849961",
      required_time: 30,
      popularity: 4,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/images/dish8.jpg"),
      ingredients_attributes: [
                                { name: "レタス", quantity: "1/4個" },
                                { name: "しゃぶしゃぶ用豚肉", quantity: "100g" },
                                { name: "三つ葉", quantity: "2束" },
                                { name: "胡椒", quantity: "1振り" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "チーズオムレツ",
      user_id: 3,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5355585",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/images/dish9.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "2個" },
                                { name: "とろけるチーズ", quantity: "大さじ2" },
                                { name: "オリーブオイル", quantity: "小さじ2" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "スペインオムレツ",
      user_id: 1,
      description: description3,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5712829",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish10.jpg"),
      ingredients_attributes: [
                                { name: "卵", quantity: "4個" },
                                { name: "じゃがいも", quantity: "1個" },
                                { name: "玉ねぎ", quantity: "0.5個" },
                                { name: "胡椒", quantity: "少々" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ぶりの照り焼き",
      user_id: 2,
      description: description1,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5628386",
      required_time: 40,
      popularity: 3,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish11.jpg"),
      ingredients_attributes: [
                                { name: "ブリ", quantity: "6枚" },
                                { name: "しょうゆ", quantity: "40ml" },
                                { name: "みりん", quantity: "100ml" },
                                { name: "酒", quantity: "80ml" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "カレーライス",
      user_id: 3,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/4779250",
      required_time: 40,
      popularity: 4,
      cook_memo: cook_memo2,
      picture: open("#{Rails.root}/public/images/dish12.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "500g" },
                                { name: "玉ねぎ", quantity: "3個" },
                                { name: "にんじん", quantity: "3本" },
                                { name: "じゃがいも", quantity: "2個" },
                                { name: "なす", quantity: "1個" },
                                { name: "カレールー", quantity: "0.5箱" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "麻婆豆腐",
      user_id: 1,
      description: description1,
      portion: portion,
      tips: tips3,
      reference: "https://cookpad.com/recipe/5908616",
      required_time: 20,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/images/dish13.jpg"),
      ingredients_attributes: [
                                { name: "牛ひき肉", quantity: "50g" },
                                { name: "絹豆腐", quantity: "2丁" },
                                { name: "麻婆豆腐の素", quantity: "1袋" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "肉豆腐",
      user_id: 2,
      description: description2,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5866590",
      required_time: 40,
      popularity: 4,
      cook_memo: cook_memo1,
      picture: open("#{Rails.root}/public/images/dish14.jpg"),
      ingredients_attributes: [
                                { name: "大葉", quantity: "4枚" },
                                { name: "薄切り肉", quantity: "100g" },
                                { name: "豆腐", quantity: "1/2丁" },
                                { name: "きのこ", quantity: "60g" },
                                { name: "しらたき", quantity: "50g" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "豚汁",
      user_id: 3,
      description: description1,
      portion: portion,
      tips: tips1,
      reference: "https://cookpad.com/recipe/5789404",
      required_time: 50,
      popularity: 5,
      cook_memo: cook_memo3,
      picture: open("#{Rails.root}/public/images/dish15.jpg"),
      ingredients_attributes: [
                                { name: "豚肉", quantity: "150g" },
                                { name: "ごぼう", quantity: "1/2本" },
                                { name: "にんじん", quantity: "1本" },
                                { name: "大根", quantity: "1/8本" },
                                { name: "こんにゃく", quantity: "50g" },
                                { name: "長ネギ", quantity: "1/2本" },
                                { name: "ごま油", quantity: "大さじ1" },
                                { name: "味噌", quantity: "大さじ4" },
                                { name: "酒", quantity: "大さじ1" },
                                { name: "七味唐辛子", quantity: "お好み" }
                              ],
    }
  ]
)

dish3 = Dish.find(3)
dish6 = Dish.find(6)
dish12 = Dish.find(12)
dish13 = Dish.find(13)
dish14 = Dish.find(14)
dish15 = Dish.find(15)

# お気に入り登録
user3.favorite(dish13)
user3.favorite(dish14)
user1.favorite(dish15)
user2.favorite(dish12)

# コメント
dish15.memos.create(user_id: user1.id, content: "美味しそう！私も食べてみたい！")
dish12.memos.create(user_id: user2.id, content: "また作ってー！")

# 通知
user3.notifications.create(user_id: user3.id, dish_id: dish15.id,
                           from_user_id: user1.id, variety: 1)
user3.notifications.create(user_id: user3.id, dish_id: dish15.id,
                           from_user_id: user1.id, variety: 2, content: "美味しそう！私も食べてみたい！")
user3.notifications.create(user_id: user3.id, dish_id: dish12.id,
                           from_user_id: user2.id, variety: 1)
user3.notifications.create(user_id: user3.id, dish_id: dish12.id,
                           from_user_id: user2.id, variety: 2, content: "また作ってー！")
# リスト
user3.list(dish3)
user1.list(dish15)
user3.list(dish6)
user2.list(dish12)

# ログ
Dish.all.each do |dish|
  Log.create!(dish_id: dish.id,
              content: dish.cook_memo)
end
