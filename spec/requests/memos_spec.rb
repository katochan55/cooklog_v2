require 'rails_helper'

RSpec.describe "メモ機能", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish) }
  let!(:memo) { create(:memo, user_id: user.id, dish_id: dish.id) }

  context "メモの登録" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "有効な内容のメモが登録できること" do
        expect {
          post memos_path, params: { dish_id: dish.id,
                                     memo: { content: "最高です！" } }
        }.to change(dish.memos, :count).by(1)
      end

      it "無効な内容のメモが登録できないこと" do
        expect {
          post memos_path, params: { dish_id: dish.id,
                                     memo: { content: "" } }
        }.not_to change(dish.memos, :count)
      end
    end

    context "ログインしていない場合" do
      it "メモは登録できず、ログインページへリダイレクトすること" do
        expect {
          post memos_path, params: { dish_id: dish.id,
                                     memo: { content: "最高です！" } }
        }.not_to change(dish.memos, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "メモの削除" do
    context "メモを作成したユーザーである場合" do
      it "メモの削除ができること" do
        login_for_request(user)
        expect {
          delete memo_path(memo)
        }.to change(dish.memos, :count).by(-1)
      end
    end

    context "メモを作成したユーザーでない場合" do
      it "メモの削除はできないこと" do
        login_for_request(other_user)
        expect {
          delete memo_path(memo)
        }.not_to change(dish.memos, :count)
      end
    end

    context "ログインしていない場合" do
      it "メモの削除はできず、ログインページへリダイレクトすること" do
        expect {
          delete memo_path(memo)
        }.not_to change(dish.memos, :count)
      end
    end
  end
end
