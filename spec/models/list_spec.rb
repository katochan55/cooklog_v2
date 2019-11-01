require 'rails_helper'

RSpec.describe List, type: :model do
  let!(:list) { create(:list) }

  it "listインスタンスが有効であること" do
    expect(list).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    list.user_id = nil
    expect(list).not_to be_valid
  end

  it "dish_idがnilの場合、無効であること" do
    list.dish_id = nil
    expect(list).not_to be_valid
  end

  it "from_user_idがnilの場合、無効であること" do
    list.from_user_id = nil
    expect(list).not_to be_valid
  end
end
