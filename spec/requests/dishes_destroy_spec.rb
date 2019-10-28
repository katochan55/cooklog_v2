require "rails_helper"

RSpec.describe "ユーザーの削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "ログインしている場合" do
    # it "自分の料理を削除でき、その後マイページにリダイレクトすること" do
    #   login_for_request(user)
    #   expect {
    #     delete dish_path(dish)
    #   }.to change(Dish, :count).by(-1)
    #   redirect_to user_path(user)
    #   follow_redirect!
    # end
    #
    # it "自分以外のユーザーの料理を削除しようとすると、トップページへリダイレクトすること" do
    #   login_for_request(user)
    #   expect {
    #     delete dish_path(dish)
    #   }.to_not change(Dish, :count)
    #   expect(response).to have_http_status "302"
    #   expect(response).to redirect_to root_path
    # end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete dish_path(dish)
      }.to_not change(Dish, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
