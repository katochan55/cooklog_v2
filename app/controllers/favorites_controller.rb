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
    # 自分以外のユーザーからお気に入り登録があったときのみ通知を作成
    if @user != current_user
      @user.notifications.create(dish_id: @dish.id, variety: 1, from_user_id: current_user.id) # お気に入り登録は通知種別1
      @user.update_attribute(:notification, true)
    end
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
