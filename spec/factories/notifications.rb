FactoryBot.define do
  factory :notification do
    dish_id { 1 }
    variety { 1 }
    association :user
  end
end
