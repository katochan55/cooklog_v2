class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @dishes = Dish.where(user_id: current_user.id)
    @lists = []
    @dishes.each do |dish|
      @lists << List.where("dish_id = ?", dish.id)
    end
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
    @dish = Dish.find(params[:dish_id])
    current_user.lists.find_by(dish_id: @dish.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
