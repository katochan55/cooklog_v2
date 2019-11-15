require "rails_helper"

RSpec.describe "料理一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, :ingredients, user: user) }

  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get dishes_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('dishes/index')
    end

    it "CSV出力がエラーなく行えること" do
      login_for_request(user)
      get dishes_path(format: :csv)
      expect(response).to have_http_status "200"
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get dishes_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
