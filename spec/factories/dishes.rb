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
    created_at { Time.current }
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/dish1.jpg')) }

    trait :yesterday do
      created_at { 1.day.ago }
    end

    trait :one_week_ago do
      created_at { 1.week.ago }
    end

    trait :one_month_ago do
      created_at { 1.month.ago }
    end
  end
end
