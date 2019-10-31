require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(notification).to be_valid
    end

    it "user_idがなければ無効な状態であること" do
      notification = build(:notification, user_id: nil)
      expect(notification).not_to be_valid
    end

    it "dish_idがなければ無効な状態であること" do
      notification = build(:notification, dish_id: nil)
      expect(notification).not_to be_valid
    end

    it "内容がなければ無効な状態であること" do
      notification = build(:notification, content: nil)
      expect(notification).not_to be_valid
    end
  end
end
