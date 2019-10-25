require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "ログインページ" do
    before do
      get :new
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "ログインページが表示される" do
      expect(response).to render_template :new
    end
  end
end
