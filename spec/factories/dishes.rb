FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    description { "冬に食べたくなる、身体が温まる料理です" } # Faker::Food.descriptionも使用可
    portion { 1.5 }
    tips { "ピリッと辛めに味付けするのがオススメ" }
    reference { "https://cookpad.com/recipe/2798655" }
    cook_times { 1 }
    required_time { 30 }
    popularity { 5 }
    association :user
  end
end
