FactoryBot.define do
  factory :log do
    content { "塩を多めに入れてもいいかも" }
    association :dish
  end
end
