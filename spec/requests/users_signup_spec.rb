require "rails_helper"

RSpec.describe "ユーザー登録", type: :request do
  example "有効なユーザーで登録" do
    get signup_path
    expect {
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    }.to change(User, :count).by(1)
    redirect_to @user
    follow_redirect!
    expect(response).to render_template('users/show')
    expect(is_logged_in?).to be_truthy
  end

  example "無効なユーザーで登録" do
    get signup_path
    expect {
      post users_path, params: { user: { name:  "",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "pass" } }
    }.to_not change(User, :count)
    expect(is_logged_in?).to_not be_truthy
  end
end
