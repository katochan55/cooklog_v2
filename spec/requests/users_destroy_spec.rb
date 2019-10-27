require "rails_helper"

RSpec.describe "ユーザーの削除", type: :request do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }

  context "管理者ユーザーの場合" do
    it "ユーザーを削除後、ユーザー一覧ページにリダイレクト" do
      login_for_request(admin_user)
      expect {
        delete user_path(user)
      }.to change(User, :count).by(-1)
      redirect_to users_url
      follow_redirect!
      expect(response).to render_template('users/index')
    end
  end

  context "管理者以外のユーザーの場合" do
    it "トップページへリダイレクトすること" do
      login_for_request(user)
      expect {
        delete user_path(admin_user)
      }.to_not change(User, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete user_path(user)
      }.to_not change(User, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
