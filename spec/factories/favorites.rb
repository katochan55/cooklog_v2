FactoryBot.define do
  factory :favorite do
    # dish_id { 1 }
    association :dish
    association :user
  end
end
