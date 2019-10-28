require 'rails_helper'

RSpec.describe Dish, type: :model do
  let(:dish) { create(:dish) }

  context "バリデーション" do
    it "有効な状態であること" do
      puts dish.name
      expect(dish).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      dish = build(:dish, name: nil)
      dish.valid?
      expect(dish.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      dish = build(:dish, name: "あ"*31)
      dish.valid?
      expect(dish.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が50文字以内であること" do
      dish = build(:dish, description: "あ"*51)
      dish.valid?
      expect(dish.errors[:description]).to include("は50文字以内で入力してください")
    end

    it "コツ・ポイントが50文字以内であること" do
      dish = build(:dish, tips: "あ"*51)
      dish.valid?
      expect(dish.errors[:tips]).to include("は50文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      dish = build(:dish, user_id: nil)
      dish.valid?
      expect(dish.errors[:user_id]).to include("を入力してください")
    end
  end
end
