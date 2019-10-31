FactoryBot.define do
  factory :notification do
    dish_id { 1 }
    variety { 1 }
    content { "" }
    from_user_id { 2 }
    association :user
  end
end
