require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:other_dish) { create(:dish, user: other_user) }

  describe "ユーザー一覧ページ" do
    it "ぺージネーション、削除ボタンが表示されること" do
      create_list(:user, 31)
      login_for_system(admin_user)
      visit users_path
      expect(page).to have_css "div.pagination"
      User.paginate(page: 1).each do |u|
        expect(page).to have_link u.name, href: user_path(u)
        expect(page).to have_content "削除"
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

    context "ユーザー登録処理" do
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
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit user_path(user)
      click_link "プロフィール編集"
    end

    context "ページレイアウト" do
      it "「プロフィール編集」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール編集'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール編集')
      end
    end

    context "プロフィール更新処理" do
      it "有効なプロフィール更新" do
        fill_in "ユーザー名", with: "Edit Example User"
        fill_in "メールアドレス", with: "edit-user@example.com"
        fill_in "自己紹介", with: "編集：初めまして"
        fill_in "性別", with: "編集：男性"
        click_button "更新する"
        expect(page).to have_content "プロフィールが更新されました！"
        expect(user.reload.name).to eq "Edit Example User"
        expect(user.reload.email).to eq "edit-user@example.com"
        expect(user.reload.introduction).to eq "編集：初めまして"
        expect(user.reload.sex).to eq "編集：男性"
      end

      it "無効なプロフィール更新" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: ""
        click_button "更新する"
        expect(page).to have_content 'ユーザー名を入力してください'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).to have_content 'メールアドレスは不正な値です'
        expect(user.reload.email).not_to eq ""
      end
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        create_list(:dish, 10, user: user)
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.sex
        expect(page).to have_content "#{user.following.count}人をフォロー"
        expect(page).to have_content "#{user.followers.count}人のフォロワー"
      end

      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
      end

      it "アカウントの削除リンクが表示されていることを確認" do
        expect(page).to have_link 'アカウント削除', href: user_path(user)
      end

      it "料理の件数が表示されていることを確認" do
        expect(page).to have_content "料理 (#{user.dishes.count})"
      end

      it "料理の情報が表示されていることを確認" do
        Dish.take(5).each do |dish|
          expect(page).to have_link dish.name
          expect(page).to have_content dish.description
          expect(page).to have_content dish.user.name
          expect(page).to have_content dish.logs.count
          expect(page).to have_content dish.required_time
          expect(page).to have_content dish.popularity
        end
      end

      it "料理のページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end

    context "料理の削除処理", js: true do
      it "削除成功のフラッシュが表示されることを確認" do
        login_for_system(user)
        visit user_path(user)
        within find("#dish-#{dish.id}") do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'お料理が削除されました'
      end
    end

    context "ユーザーのフォロー/アンフォロー処理", js: true do
      it "ユーザーのフォロー/アンフォローができること" do
        login_for_system(user)
        visit user_path(other_user)
        expect(page).to have_button 'フォローする'
        click_button 'フォローする'
        expect(page).to have_button 'フォロー中'
        click_button 'フォロー中'
        expect(page).to have_button 'フォローする'
      end
    end

    context "お気に入り登録/解除" do
      before do
        login_for_system(user)
      end

      it "料理のお気に入り登録/解除ができること" do
        expect(user.favorite?(dish)).to be_falsey
        user.favorite(dish)
        expect(user.favorite?(dish)).to be_truthy
        user.unfavorite(dish)
        expect(user.favorite?(dish)).to be_falsey
      end

      it "トップページからお気に入り登録/解除ができること", js: true do
        visit root_path
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{dish.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
      end

      it "ユーザー個別ページからお気に入り登録/解除ができること", js: true do
        visit user_path(user)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{dish.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
      end

      it "料理個別ページからお気に入り登録/解除ができること", js: true do
        visit dish_path(dish)
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
        link.click
        link = find('.unlike')
        expect(link[:href]).to include "/favorites/#{dish.id}/destroy"
        link.click
        link = find('.like')
        expect(link[:href]).to include "/favorites/#{dish.id}/create"
      end

      it "お気に入り一覧ページが期待通り表示されること" do
        visit favorites_path
        expect(page).not_to have_css ".favorite-dish"
        user.favorite(dish)
        user.favorite(other_dish)
        visit favorites_path
        expect(page).to have_css ".favorite-dish", count: 2
        expect(page).to have_content dish.name
        expect(page).to have_content dish.description
        expect(page).to have_content "cooked by #{user.name}"
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_content other_dish.name
        expect(page).to have_content other_dish.description
        expect(page).to have_content "cooked by #{other_user.name}"
        expect(page).to have_link other_user.name, href: user_path(other_user)
        user.unfavorite(other_dish)
        visit favorites_path
        expect(page).to have_css ".favorite-dish", count: 1
        expect(page).to have_content dish.name
      end
    end

    context "通知生成" do
      before do
        login_for_system(user)
      end

      context "自分以外のユーザーの料理に対して" do
        before do
          visit dish_path(other_dish)
        end

        it "お気に入り登録によって通知が作成されること" do
          find('.like').click
          visit dish_path(other_dish)
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの料理が#{user.name}さんにお気に入り登録されました。"
          expect(page).to have_content other_dish.name
          expect(page).to have_content other_dish.description
          expect(page).to have_content other_dish.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end

        it "コメントによって通知が作成されること" do
          fill_in "memo_content", with: "コメントしました"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの料理に#{user.name}さんがコメントしました。"
          expect(page).to have_content '「コメントしました」'
          expect(page).to have_content other_dish.name
          expect(page).to have_content other_dish.description
          expect(page).to have_content other_dish.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end
      end

      context "自分の料理に対して" do
        before do
          visit dish_path(dish)
        end

        it "お気に入り登録によって通知が作成されないこと" do
          find('.like').click
          visit dish_path(dish)
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'お気に入りに登録されました。'
          expect(page).not_to have_content dish.name
          expect(page).not_to have_content dish.description
          expect(page).not_to have_content dish.created_at
        end

        it "コメントによって通知が作成されないこと" do
          fill_in "memo_content", with: "自分でコメント"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'コメントしました。'
          expect(page).not_to have_content '自分でコメント'
          expect(page).not_to have_content other_dish.name
          expect(page).not_to have_content other_dish.description
          expect(page).not_to have_content other_dish.created_at
        end
      end
    end
  end

  context "リスト登録/解除" do
    before do
      login_for_system(user)
    end

    it "料理のお気に入り登録/解除ができること" do
      expect(user.list?(dish)).to be_falsey
      user.list(dish)
      expect(user.list?(dish)).to be_truthy
      user.unlist(List.first)
      expect(user.list?(dish)).to be_falsey
    end

    it "トップページからリスト登録/解除ができること", js: true do
      visit root_path
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
      link.click
      link = find('.unlist')
      expect(link[:href]).to include "/lists/#{List.first.id}/destroy"
      link.click
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
    end

    it "ユーザー個別ページからリスト登録/解除ができること", js: true do
      visit user_path(user)
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
      link.click
      link = find('.unlist')
      expect(link[:href]).to include "/lists/#{List.first.id}/destroy"
      link.click
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
    end

    it "料理個別ページからリスト登録/解除ができること", js: true do
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
      link.click
      link = find('.unlist')
      expect(link[:href]).to include "/lists/#{List.first.id}/destroy"
      link.click
      link = find('.list')
      expect(link[:href]).to include "/lists/#{dish.id}/create"
    end

    it "リスト一覧ページが期待通り表示され、リストから削除することもできること" do
      visit lists_path
      expect(page).not_to have_css ".list-dish"
      user.list(dish)
      dish_2 = create(:dish, user: user)
      other_user.list(dish_2)
      visit lists_path
      expect(page).to have_css ".list-dish", count: 2
      expect(page).to have_content dish.name
      expect(page).to have_content dish.description
      expect(page).to have_content List.last.created_at.strftime("%Y/%m/%d(%a) %H:%M")
      expect(page).to have_content "この料理を作る予定リストに追加しました。"
      expect(page).to have_content dish_2.name
      expect(page).to have_content dish_2.description
      expect(page).to have_content List.first.created_at.strftime("%Y/%m/%d(%a) %H:%M")
      expect(page).to have_content "#{other_user.name}さんがこの料理に食べたいリクエストをしました。"
      expect(page).to have_link other_user.name, href: user_path(other_user)
      user.unlist(List.first)
      visit lists_path
      expect(page).to have_css ".list-dish", count: 1
      expect(page).to have_content dish.name
      find('.unlist').click
      visit lists_path
      expect(page).not_to have_css ".list-dish"
    end
  end
end
