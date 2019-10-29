require "rails_helper"

RSpec.describe "お料理登録", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      get record_dish_path
      login_for_request(user)
    end

    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      expect(response).to redirect_to record_dish_url
    end

    it "有効なデータを持つ料理が登録できること" do
      expect {
        post dishes_path, params: { dish: { name:  "イカの塩焼き",
                                           description: "冬に食べたくなる、身体が温まる料理です",
                                           portion: 1.5,
                                           tips: "ピリッと辛めに味付けするのがオススメ",
                                           reference: "https://cookpad.com/recipe/2798655",
                                           cook_times: 1,
                                           required_time: 30,
                                           popularity: 5 } }
      }.to change(Dish, :count).by(1)
      redirect_to @dish
      follow_redirect!
      expect(response).to render_template('dishes/show')
    end

    it "無効なデータを持つ料理は登録できないこと" do
      expect {
        post dishes_path, params: { dish: { name:  "",
                                           description: "冬に食べたくなる、身体が温まる料理です",
                                           portion: 1.5,
                                           tips: "ピリッと辛めに味付けするのがオススメ",
                                           reference: "https://cookpad.com/recipe/2798655",
                                           cook_times: 1,
                                           required_time: 30,
                                           popularity: 5 } }
      }.to_not change(Dish, :count)
      expect(response).to render_template('dishes/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get record_dish_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
