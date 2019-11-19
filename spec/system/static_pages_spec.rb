require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "クックログの文字列が存在することを確認" do
        expect(page).to have_content 'クックログ'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end
    end

    context "料理フィード", js: true do
      let!(:user) { create(:user) }
      let!(:dish) { create(:dish, user: user) }

      before do
        login_for_system(user)
      end

      it "料理のぺージネーションが表示されること" do
        create_list(:dish, 6, user: user)
        visit root_path
        expect(page).to have_content "みんなの料理 (#{user.dishes.count})"
        expect(page).to have_css "div.pagination"
        Dish.take(5).each do |d|
          expect(page).to have_link d.name, href: dish_path(d)
        end
      end

      it "「新しい料理を作る」リンクが表示されること" do
        visit root_path
        expect(page).to have_link "新しい料理を作る", href: record_dish_path
      end

      it "料理を削除後、削除成功のフラッシュが表示されること" do
        visit root_path
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '料理が削除されました'
      end
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
