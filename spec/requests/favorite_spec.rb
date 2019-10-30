require 'rails_helper'

RSpec.describe "お気に入り登録機能", type: :request do
  let(:user) { create(:user) }
  let(:dish) { create(:dish) }

  context "ログインしている場合" do
    before do
      login_for_request(user)
    end

    it "料理のお気に入り登録ができること" do
      expect {
        post "/favorites/#{dish.id}/create"
      }.to change(user.favorites, :count).by(1)
    end

    it "料理のAjaxによるお気に入り登録ができること" do
      expect {
        post "/favorites/#{dish.id}/create", xhr: true
      }.to change(user.favorites, :count).by(1)
    end

    it "料理のお気に入り解除ができること" do
      user.favorite(dish)
      expect {
        delete "/favorites/#{dish.id}/destroy"
      }.to change(user.favorites, :count).by(-1)
    end

    it "料理のAjaxによるお気に入り解除ができること" do
      user.favorite(dish)
      expect {
        delete "/favorites/#{dish.id}/destroy", xhr: true
      }.to change(user.favorites, :count).by(-1)
    end
  end

  context "ログインしていない場合" do
    it "createアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        post "/favorites/#{dish.id}/create"
      }.not_to change(Favorite, :count)
      expect(response).to redirect_to login_path
    end

    it "destroyアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        delete "/favorites/#{dish.id}/destroy"
      }.not_to change(Favorite, :count)
      expect(response).to redirect_to login_path
    end
  end
end
