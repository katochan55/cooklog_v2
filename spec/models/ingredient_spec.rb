require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let!(:ingredient) { create(:ingredient) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(ingredient).to be_valid
    end
  end
end
