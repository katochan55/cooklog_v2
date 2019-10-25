require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    it "「ユーザー登録」の文字列が存在することを確認" do
      expect(page).to have_content 'ユーザー登録'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('ユーザー登録')
    end

    it "ヘッダーにユーザー登録ページへのリンクがあることを確認" do
      expect(page).to have_link 'ユーザー登録(無料)', href: signup_path
    end

    it "ユーザー登録フォームのラベルが正しく表示される" do
      expect(page).to have_content 'ユーザー名'
      expect(page).to have_content 'メールアドレス'
      expect(page).to have_content 'パスワード'
      expect(page).to have_content 'パスワード(確認)'
    end

    it "ユーザー登録フォームが正しく表示される" do
      expect(page).to have_css 'input#user_name'
      expect(page).to have_css 'input#user_email'
      expect(page).to have_css 'input#user_password'
      expect(page).to have_css 'input#user_password_confirmation'
    end

    it "ユーザー登録ボタンが表示される" do
      expect(page).to have_button '登録する'
    end

    it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Example User"
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード(確認)", with: "password"
      click_button "登録する"
      expect(page).to have_content "クックログへようこそ！"
    end

    it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード(確認)", with: "pass"
      click_button "登録する"
      expect(page).to have_content "ユーザー名を入力してください"
      expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
    end
  end

  describe "マイ(ユーザー個別)ページ" do
    let!(:user) { create(:user) }

    before do
      visit user_path(user)
    end

    it "「マイページ」の文字列が存在することを確認" do
      expect(page).to have_content 'マイページ'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('マイページ')
    end

    it "ユーザー情報が表示されることを確認" do
      expect(page).to have_content user.name
      expect(page).to have_content user.email
      expect(page).to have_content user.introduction
      expect(page).to have_content user.sex
    end
  end
end
