require "rails_helper"

RSpec.describe "ログイン", type: :request do
  let!(:user) { create(:user) }

  example "有効なユーザーでログイン＆ログアウト" do
    get login_path
    post login_path, params: { session: { email: user.email,
                                       password: user.password } }
    redirect_to @user
    follow_redirect!
    expect(response).to render_template('users/show')
    expect(is_logged_in?).to be_truthy
    delete logout_path
    expect(is_logged_in?).to_not be_truthy
    redirect_to root_url
    delete logout_path
    follow_redirect!
  end

  example "無効なユーザーでログイン" do
    get login_path
    post login_path, params: { session: { email: "xxx@example.com",
                                       password: user.password } }
    expect(is_logged_in?).to_not be_truthy
  end

  example "「ログインしたままにする」にチェックしてログイン" do
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: '1'} }
    expect(response.cookies['remember_token']).to_not eq nil
  end

  example "「ログインしたままにする」にチェックせずにログイン" do
    # クッキーを保存してログイン
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: '1'} }
    delete logout_path
    # クッキーを保存せずにログイン
    post login_path, params: { session: { email: user.email,
                                    password: user.password,
                                    remember_me: '0'} }
    expect(response.cookies['remember_token']).to eq nil
  end
end
