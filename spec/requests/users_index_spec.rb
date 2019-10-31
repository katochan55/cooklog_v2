require "rails_helper"

RSpec.describe "ユーザー一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }

  context "管理者ユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(admin_user)
      get users_path
      expect(response).to render_template('users/index')
    end
  end

  # context "管理者以外のユーザーの場合" do
  #   it "トップページへリダイレクトすること" do
  #     login_for_request(user)
  #     get users_path
  #     expect(response).to have_http_status "302"
  #     expect(response).to redirect_to root_path
  #   end
  # end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすること" do
      get users_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  it "admin属性の変更が禁止されていること" do
    login_for_request(user)
    expect(user.admin).to be_falsey
    patch user_path(user), params: { user: { password: user.password,
                                                    password_confirmation: user.password,
                                                    admin: true } }
    expect(user.reload.admin).to be_falsey
  end
end
