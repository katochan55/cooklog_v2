require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  describe "ログインページ" do
    let!(:user) { create(:user) }
    before do
      visit login_path
    end

    it "「ログイン」の文字列が存在することを確認" do
      expect(page).to have_content 'ログイン'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('ログイン')
    end

    it "ヘッダーにログインページへのリンクがあることを確認" do
      expect(page).to have_link 'ログイン', href: login_path
    end

    it "ログインフォームのラベルが正しく表示される" do
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'パスワード'
    end

    it "ログインフォームが正しく表示される" do
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
    end

    it "「ログインしたままにする」チェックボックスが表示される" do
      expect(page).to have_content 'ログインしたままにする'
      expect(page).to have_css 'input#session_remember_me'
    end

    it "ログインボタンが表示される" do
      expect(page).to have_button 'ログイン'
    end

    it "無効なユーザーでログインを行うとログインが失敗することを確認" do
      fill_in "user_email", with: "user@example.com"
      fill_in "user_password", with: "pass"
      click_button "ログイン"
      expect(page).to have_content 'メールアドレスとパスワードの組み合わせが誤っています'

      visit root_path
      expect(page).to_not have_content "メールアドレスとパスワードの組み合わせが誤っています"
    end

    it "有効なユーザーでログインする前後でヘッダーが正しく表示されていることを確認" do
      expect(page).to have_content 'クックログとは？'
      expect(page).to have_content 'ユーザー登録(無料)'
      expect(page).to have_content 'ログイン'
      expect(page).to_not have_content 'ログアウト'

      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "ログイン"

      expect(page).to have_content 'クックログとは？'
      expect(page).to have_content 'お気に入り'
      expect(page).to have_content 'リスト'
      expect(page).to have_content 'マイページ'
      expect(page).to have_content 'ログアウト'
      expect(page).to_not have_content 'ログイン'
    end
  end
end
