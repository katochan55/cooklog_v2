require 'rails_helper'

RSpec.describe "ユーザーフォロー機能", type: :request do
  let(:user) { create(:user) }

  context "ログインしている場合" do

  end

  context "ログインしていない場合" do
    it "followingページへ飛ぶとログインページへリダイレクトすること" do
      get following_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "followersページへ飛ぶとログインページへリダイレクトすること" do
      get followers_user_path(user)
      expect(response).to redirect_to login_path
    end

    it "createアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        post relationships_path
      }.to_not change(Relationship, :count)
      expect(response).to redirect_to login_path
    end

    it "destroyアクションは実行できず、ログインページへリダイレクトすること" do
      expect {
        delete relationship_path(user)
      }.to_not change(Relationship, :count)
      expect(response).to redirect_to login_path
    end
  end
end
