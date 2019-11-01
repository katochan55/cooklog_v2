class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = List.where("user_id = ?", current_user.id)
  end

  def create
    @dish = Dish.find(params[:dish_id])
    @user = User.find(@dish.user_id)
    current_user.list(@dish)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @dish = Dish.find(list.dish_id)
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
