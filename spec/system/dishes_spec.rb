require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:memo) { create(:memo, dish: dish, user_id: user.id) }
  let!(:log) { create(:log, dish: dish) }

  describe "お料理登録ページ" do
    before do
      login_for_system(user)
      visit record_dish_path
    end

    context "ページレイアウト" do
      it "「お料理登録」の文字列が存在すること" do
        expect(page).to have_content 'お料理登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('お料理登録')
      end

      it "画像アップロード部分が表示されること" do
        expect(page).to have_css 'input[type=file]'
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
        attach_file "dish[picture]", "#{Rails.root}/spec/fixtures/test_dish.jpg"
        click_button "登録する"
        expect(page).to have_content "お料理が登録されました！"
        expect(page).to have_link(href: dish_path(Dish.first))
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "料理名", with: "イカの塩焼き"
        click_button "登録する"
        expect(page).to have_link(href: dish_path(Dish.first))
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
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('料理情報の編集')
      end
    end

    context "料理の更新処理" do
      it "有効な更新" do
        dish = create(:dish, :picture, user: user)
        visit dish_path(dish)
        click_link "編集"
        fill_in "料理名", with: "編集：イカの塩焼き"
        fill_in "説明", with: "編集：冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 3
        fill_in "コツ・ポイント", with: "編集：ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方の参照URL", with: "henshu-https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 60
        fill_in "人気度", with: 1
        attach_file "dish[picture]", "#{Rails.root}/spec/fixtures/test_dish2.jpg"
        click_button "更新する"
        expect(page).to have_content "お料理情報が更新されました！"
        expect(dish.reload.name).to eq "編集：イカの塩焼き"
        expect(dish.reload.description).to eq "編集：冬に食べたくなる、身体が温まる料理です"
        expect(dish.reload.portion).to eq 3
        expect(dish.reload.tips).to eq "編集：ピリッと辛めに味付けするのがオススメ"
        expect(dish.reload.reference).to eq "henshu-https://cookpad.com/recipe/2798655"
        expect(dish.reload.required_time).to eq 60
        expect(dish.reload.popularity).to eq 1
        expect(dish.reload.picture.url).to include "test_dish2.jpg"
      end

      it "無効な更新" do
        fill_in "料理名", with: ""
        click_button "更新する"
        expect(page).to have_content '料理名を入力してください'
        expect(dish.reload.name).not_to eq ""
      end
    end

    context "料理の削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お料理が削除されました'
      end
    end
  end

  describe "お料理詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit dish_path(dish)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{dish.name}")
      end

      it "料理情報が表示されること" do
        expect(page).to have_content dish.name
        expect(page).to have_content dish.description
        expect(page).to have_content dish.tips
        expect(page).to have_content dish.reference
        expect(page).to have_content dish.required_time
        expect(page).to have_content dish.popularity
      end

      it "料理の編集リンクが表示されていること" do
        expect(page).to have_link '編集', href: edit_dish_path(dish)
      end
    end

    context "料理の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit dish_path(dish)
        within find('.change-dish') do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お料理が削除されました'
      end
    end

    context "コメントの登録＆削除" do
      it "自分の料理に対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit dish_path(dish)
        fill_in "memo_content", with: "今日の味付けは大成功"
        click_button "コメント"
        within find("#memo-#{Memo.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: '今日の味付けは大成功'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: memo_path(Memo.last)
        expect(page).not_to have_selector 'span', text: '今日の味付けは大成功'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーの料理のコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit dish_path(dish)
        within find("#memo-#{memo.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: memo.content
          expect(page).not_to have_link '削除', href: dish_path(dish)
        end
      end
    end

    context "ログ登録＆削除" do
      context "料理詳細ページから" do
        it "自分の料理に対するログ登録＆削除が正常に完了すること" do
          login_for_system(user)
          visit dish_path(dish)
          fill_in "log_content", with: "ログ投稿テスト"
          click_button "ログ追加"
          within find("#log-#{Log.first.id}") do
            expect(page).to have_selector 'span', text: "#{dish.logs.count}回目"
            expect(page).to have_selector 'span', text: %Q{#{Log.last.created_at.strftime("%Y/%m/%d(%a)")}}
            expect(page).to have_selector 'span', text: 'ログ投稿テスト'
          end
          expect(page).to have_content "クックログを追加しました！"
          click_link "削除", href: log_path(Log.first)
          expect(page).not_to have_selector 'span', text: 'ログ投稿テスト'
          expect(page).to have_content "クックログを削除しました"
        end

        it "別ユーザーの料理ログにはログ登録フォームが無いこと" do
          login_for_system(other_user)
          visit dish_path(dish)
          expect(page).not_to have_button "作る"
        end
      end

      context "トップページから" do
        it "自分の料理に対するログ登録が正常に完了すること" do
          login_for_system(user)
          visit root_path
          fill_in "log_content", with: "ログ投稿テスト"
          click_button "作る"
          expect(Log.first.content).to eq 'ログ投稿テスト'
          expect(page).to have_content "クックログを追加しました！"
        end

        it "別ユーザーの料理にはログ登録フォームがないこと" do
          create(:dish, user: other_user)
          login_for_system(user)
          user.follow(other_user)
          visit root_path
          within find("#dish-#{Dish.first.id}") do
            expect(page).not_to have_button "作る"
          end
        end
      end

      context "マイページから" do
        it "自分の料理に対するログ登録が正常に完了すること" do
          login_for_system(user)
          visit user_path(user)
          fill_in "log_content", with: "ログ投稿テスト"
          click_button "作る"
          expect(Log.first.content).to eq 'ログ投稿テスト'
          expect(page).to have_content "クックログを追加しました！"
        end
      end

      context "リスト一覧ページから" do
        it "自分の料理に対するログ登録が正常に完了し、リストから料理が削除されること" do
          login_for_system(user)
          user.list(dish)
          visit lists_path
          expect(page).to have_content dish.name
          fill_in "log_content", with: "ログ投稿テスト"
          click_button "作る"
          expect(Log.first.content).to eq 'ログ投稿テスト'
          expect(page).to have_content "クックログを追加しました！"
          expect(List.count).to eq 0
        end
      end
    end
  end
end
