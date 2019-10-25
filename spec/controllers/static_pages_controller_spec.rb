require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "トップページ" do
    before do
      get :home
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "トップページが表示される" do
      expect(response).to render_template :home
    end
  end

  describe "ヘルプページ" do
    before do
      get :about
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "クックログとは？ページが表示される" do
      expect(response).to render_template :about
    end
  end

  describe "利用規約ページ" do
    before do
      get :terms
    end

    it "レスポンスが正常である" do
      expect(response).to be_successful
    end

    it "利用規約ページが表示される" do
      expect(response).to render_template :terms
    end
  end
end
