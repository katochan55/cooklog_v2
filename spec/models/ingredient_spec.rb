require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let!(:ingredient) { create(:ingredient) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(ingredient).to be_valid
    end

    it "nameがなければ無効な状態であること" do
      ingredient = build(:ingredient, name: nil)
      expect(ingredient).not_to be_valid
    end
  end
end
