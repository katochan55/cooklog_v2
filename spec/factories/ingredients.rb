FactoryBot.define do
  factory :ingredient do
    name { "小麦粉" }
    quantity { "100g" }
    association :dish
  end
end
