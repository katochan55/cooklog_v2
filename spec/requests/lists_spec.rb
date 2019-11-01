require 'rails_helper'

RSpec.describe "リスト登録機能", type: :request do
  let(:user) { create(:user) }
  let(:dish) { create(:dish) }

  context "リスト一覧ページの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get lists_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('lists/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get lists_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end

  # context "リスト登録/解除機能" do
  #   context "ログインしている場合" do
  #     before do
  #       login_for_request(user)
  #     end
  #
  #     it "料理のリスト登録ができること" do
  #       expect {
  #         post
  #       }.to change(user.lists, :count).by(1)
  #     end
  #
  #     it "料理のリスト解除ができること" do
  #       user.favorite(dish)
  #       expect {
  #         delete "/favorites/#{dish.id}/destroy"
  #       }.to change(user.favorites, :count).by(-1)
  #     end
  #   end
  #
  #   context "ログインしていない場合" do
  #     it "リスト登録は実行できず、ログインページへリダイレクトすること" do
  #       expect {
  #         post
  #       }.not_to change(Favorite, :count)
  #       expect(response).to redirect_to login_path
  #     end
  #
  #     it "リスト解除は実行できず、ログインページへリダイレクトすること" do
  #       expect {
  #         delete
  #       }.not_to change(Favorite, :count)
  #       expect(response).to redirect_to login_path
  #     end
  #   end
  # end
end
