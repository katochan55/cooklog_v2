require 'rails_helper'

RSpec.describe Memo, type: :model do
  let!(:memo) { create(:memo) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(memo).to be_valid
    end

    it "user_idがなければ無効な状態であること" do
      memo = build(:memo, user_id: nil)
      memo.valid?
      expect(memo.errors[:user_id]).to include("を入力してください")
    end

    it "dish_idがなければ無効な状態であること" do
      memo = build(:memo, dish_id: nil)
      memo.valid?
      expect(memo.errors[:dish_id]).to include("を入力してください")
    end

    it "内容がなければ無効な状態であること" do
      memo = build(:memo, content: nil)
      memo.valid?
      expect(memo.errors[:content]).to include("を入力してください")
    end

    it "内容が50文字以内であること" do
      memo = build(:memo, content: "あ" * 51)
      memo.valid?
      expect(memo.errors[:content]).to include("は50文字以内で入力してください")
    end
  end
end
