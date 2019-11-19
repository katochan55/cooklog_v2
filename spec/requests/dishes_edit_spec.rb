require "rails_helper"

RSpec.describe "料理編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/test_dish2.jpg') }
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_dish_path(dish)
      login_for_request(user)
      expect(response).to redirect_to edit_dish_url(dish)
      patch dish_path(dish), params: { dish: { name:  "イカの塩焼き",
                                               description: "冬に食べたくなる、身体が温まる料理です",
                                               portion: 1.5,
                                               tips: "ピリッと辛めに味付けするのがオススメ",
                                               reference: "https://cookpad.com/recipe/2798655",
                                               required_time: 30,
                                               popularity: 5,
                                               picture: picture2,
                                               ingredients_attributes: [
                                                 name: "編集-じゃがいも",
                                                 quantity: "編集-2個"] } }
      redirect_to dish
      follow_redirect!
      expect(response).to render_template('dishes/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_dish_path(dish)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch dish_path(dish), params: { dish: { name:  "イカの塩焼き",
                                               description: "冬に食べたくなる、身体が温まる料理です",
                                               portion: 1.5,
                                               tips: "ピリッと辛めに味付けするのがオススメ",
                                               reference: "https://cookpad.com/recipe/2798655",
                                               required_time: 30,
                                               popularity: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      # 編集
      login_for_request(other_user)
      get edit_dish_path(dish)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch dish_path(dish), params: { dish: { name:  "イカの塩焼き",
                                               description: "冬に食べたくなる、身体が温まる料理です",
                                               portion: 1.5,
                                               tips: "ピリッと辛めに味付けするのがオススメ",
                                               reference: "https://cookpad.com/recipe/2798655",
                                               required_time: 30,
                                               popularity: 5,
                                               ingredients_attributes: [
                                                 name: "編集-じゃがいも",
                                                 quantity: "編集-2個"] } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
