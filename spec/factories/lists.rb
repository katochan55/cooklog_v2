FactoryBot.define do
  factory :list do
    dish_id { 1 }
    from_user_id { 1 }
    association :user
  end
end