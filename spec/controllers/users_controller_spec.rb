require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "ユーザー登録ページ" do
    before do
      get :new
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "ユーザー登録ページが表示される" do
      expect(response).to render_template :new
    end
  end

  describe "マイ(ユーザー個別)ページ" do
    let!(:user) { create(:user) }

    before do
      get :show, params: { id: user.id }
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "ユーザー登録ページが表示される" do
      expect(response).to render_template :show
    end

    it "@userがアサインされる" do
      expect(assigns(:user)).to eq user
    end
  end
end
