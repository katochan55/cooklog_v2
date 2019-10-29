require "rails_helper"

RSpec.describe "料理個別ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get dish_path(dish)
      expect(response).to have_http_status "200"
      expect(response).to render_template('dishes/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get dish_path(dish)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "フォロワーであれば正常に表示されること" do
      puts "※※後で実装※※"
    end

    it "フォロワーでなければトップページにリダイレクトすること" do
      puts "※※後で実装※※"
    end
  end
end
