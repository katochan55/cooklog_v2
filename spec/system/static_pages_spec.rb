require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    before do
      visit root_path
    end

    it "クックログの文字列が存在することを確認" do
      expect(page).to have_content 'クックログ'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title
    end

    it "ヘッダーに「クックログとは？」ページへのリンクがあることを確認" do
      expect(page).to have_link 'クックログとは？', href: about_path
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "クックログとは？の文字列が存在することを確認" do
      expect(page).to have_content 'クックログとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('クックログとは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
