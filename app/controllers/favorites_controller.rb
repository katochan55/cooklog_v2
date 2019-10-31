class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @user = User.find(@dish.user_id)
    current_user.favorite(@dish)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
    @user.notifications.create(dish_id: @dish.id,
                               content: "あなたの投稿が#{current_user.name}さんにお気に入り登録されました。")
    $NOTIFICATION_FLAG = 1
  end

  def destroy
    @dish = Dish.find(params[:dish_id])
    current_user.favorites.find_by(dish_id: @dish.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
