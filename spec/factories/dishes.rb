FactoryBot.define do
  factory :dish do
    name { Faker::Food.dish }
    description { "冬に食べたくなる、身体が温まる料理です" } # Faker::Food.descriptionも使用可
    portion { 1.5 }
    tips { "ピリッと辛めに味付けするのがオススメ" }
    reference { "https://cookpad.com/recipe/2798655" }
    required_time { 30 }
    popularity { 5 }
    association :user
    created_at { Time.current }

    trait :ingredients do
      ingredients_attributes {
                               [
                                 { name: "じゃがいも", quantity: "1個" },
                                 { name: "玉ねぎ", quantity: "2個" },
                                 { name: "ニンジン", quantity: "3個" },
                                 { name: "豚肉", quantity: "4個" },
                                 { name: "りんご", quantity: "5個" },
                                 { name: "カレールー", quantity: "6個" },
                                 { name: "隠し味", quantity: "7個" },
                                 { name: "だし", quantity: "8個" },
                                 { name: "ピーマン", quantity: "9個" },
                                 { name: "なす", quantity: "10個" }
                               ]
      }
    end

    trait :yesterday do
      created_at { 1.day.ago }
    end

    trait :one_week_ago do
      created_at { 1.week.ago }
    end

    trait :one_month_ago do
      created_at { 1.month.ago }
    end

    trait :picture do
      picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_dish.jpg')) }
    end
  end
end
