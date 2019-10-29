require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  describe "お料理登録ページ" do
    before do
      login_for_system(user)
      visit record_dish_path
    end

    context "ページレイアウト" do
      it "「お料理登録」の文字列が存在することを確認" do
        expect(page).to have_content 'お料理登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('お料理登録')
      end
    end

    context "お料理登録処理" do
      it "有効な情報でお料理登録を行うとお料理登録成功のフラッシュが表示されること" do
        fill_in "料理名", with: "イカの塩焼き"
        fill_in "説明", with: "冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 1.5
        fill_in "コツ・ポイント", with: "ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方の参照URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 30
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "お料理が登録されました！"
      end

      it "無効な情報でお料理登録を行うとお料理登録失敗のフラッシュが表示されること" do
        fill_in "料理名", with: ""
        fill_in "説明", with: "冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 1.5
        fill_in "コツ・ポイント", with: "ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方の参照URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 30
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "料理名を入力してください"
      end
    end
  end

  describe "お料理編集ページ" do
    before do
      login_for_system(user)
      visit dish_path(dish)
      click_link "お料理情報を編集する"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('料理情報の編集')
      end
    end

    context "料理の更新処理" do
      it "有効な更新" do
        fill_in "料理名", with: "編集：イカの塩焼き"
        fill_in "説明", with: "編集：冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 3
        fill_in "コツ・ポイント", with: "編集：ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方の参照URL", with: "henshu-https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 60
        fill_in "人気度", with: 1
        click_button "更新する"
        expect(page).to have_content "お料理情報が更新されました！"
        expect(dish.reload.name).to eq "編集：イカの塩焼き"
        expect(dish.reload.description).to eq "編集：冬に食べたくなる、身体が温まる料理です"
        expect(dish.reload.portion).to eq 3
        expect(dish.reload.tips).to eq "編集：ピリッと辛めに味付けするのがオススメ"
        expect(dish.reload.reference).to eq "henshu-https://cookpad.com/recipe/2798655"
        expect(dish.reload.required_time).to eq 60
        expect(dish.reload.popularity).to eq 1
      end

      it "無効な更新" do
        fill_in "料理名", with: ""
        click_button "更新する"
        expect(page).to have_content '料理名を入力してください'
        expect(dish.reload.name).to_not eq ""
      end
    end

    context "料理の削除処理", js: true do
      it "削除成功のフラッシュが表示されることを確認" do
        click_on '料理を削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お料理が削除されました'
      end
    end
  end

  describe "お料理個別ページ" do
    before do
      login_for_system(user)
      visit dish_path(dish)
    end

    context "ページレイアウト" do
      it "「お料理情報」の文字列が存在することを確認" do
        expect(page).to have_content 'お料理情報'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('お料理情報')
      end

      it "料理情報が表示されることを確認" do
        expect(page).to have_content dish.name
        expect(page).to have_content dish.description
        expect(page).to have_content dish.portion
        expect(page).to have_content dish.tips
        expect(page).to have_content dish.reference
        expect(page).to have_content dish.required_time
        expect(page).to have_content dish.popularity
      end

      it "料理の編集リンクが表示されていることを確認" do
        expect(page).to have_link 'お料理情報を編集する', href: edit_dish_path(dish)
      end
    end

    context "料理の削除処理", js: true do
      it "削除成功のフラッシュが表示されることを確認" do
        click_on 'お料理情報を削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お料理が削除されました'
      end
    end
  end
end