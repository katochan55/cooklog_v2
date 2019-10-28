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

  # describe "お料理編集ページ" do
  #   before do
  #     login_for_system(user)
  #     visit user_path(user)
  #     click_link "プロフィールを編集する"
  #   end
  #
  #   context "ページレイアウト" do
  #     it "「プロフィール編集」の文字列が存在することを確認" do
  #       expect(page).to have_content 'プロフィール編集'
  #     end
  #
  #     it "正しいタイトルが表示されることを確認" do
  #       expect(page).to have_title full_title('プロフィール編集')
  #     end
  #   end
  #
  #   context "プロフィール更新処理" do
  #     it "有効なプロフィール更新" do
  #       fill_in "ユーザー名", with: "Example User"
  #       fill_in "メールアドレス", with: "user@example.com"
  #       fill_in "自己紹介", with: "初めまして"
  #       fill_in "性別", with: "男性"
  #       click_button "更新する"
  #       expect(page).to have_content "プロフィールが保存されました！"
  #       expect(user.reload.email).to eq "user@example.com"
  #     end
  #
  #     it "無効なプロフィール更新" do
  #       fill_in "ユーザー名", with: ""
  #       fill_in "メールアドレス", with: ""
  #       click_button "更新する"
  #       expect(page).to have_content 'ユーザー名を入力してください'
  #       expect(page).to have_content 'メールアドレスを入力してください'
  #       expect(page).to have_content 'メールアドレスは不正な値です'
  #       expect(user.reload.email).to_not eq ""
  #     end
  #   end
  # end

  # describe "お料理個別ページ" do
  #   context "ページレイアウト" do
  #     before do
  #       create_list(:dish, 10, user: user)
  #       visit user_path(user)
  #     end
  #
  #     it "「マイページ」の文字列が存在することを確認" do
  #       expect(page).to have_content 'マイページ'
  #     end
  #
  #     it "正しいタイトルが表示されることを確認" do
  #       expect(page).to have_title full_title('マイページ')
  #     end
  #
  #     it "ユーザー情報が表示されることを確認" do
  #       expect(page).to have_content user.name
  #       expect(page).to have_content user.introduction
  #       expect(page).to have_content user.sex
  #     end
  #
  #     it "プロフィール編集ページへのリンクが表示されていることを確認" do
  #       expect(page).to have_link 'プロフィールを編集する', href: edit_user_path(user)
  #     end
  #
  #     it "アカウントの削除リンクが表示されていることを確認" do
  #       expect(page).to have_link 'アカウントを削除する', href: user_path(user)
  #     end
  #
  #     it "料理の件数が表示されていることを確認" do
  #       expect(page).to have_content "料理 #{user.dishes.count}件"
  #     end
  #
  #     it "料理の情報が表示されていることを確認" do
  #       Dish.take(5).each do |dish|
  #         expect(page).to have_link dish.name
  #         expect(page).to have_content dish.description
  #         expect(page).to have_content dish.cook_times
  #         expect(page).to have_content dish.required_time
  #         expect(page).to have_content dish.popularity
  #         expect(page).to have_link "作り方", href: dish.reference
  #       end
  #     end
  #
  #     it "料理のページネーションが表示されていることを確認" do
  #       expect(page).to have_css "div.pagination"
  #     end
  #   end
  # end
end
