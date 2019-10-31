FactoryBot.define do
  factory :notification do
    dish_id { 1 }
    content { "通知サンプル" }
    association :user
  end
end
