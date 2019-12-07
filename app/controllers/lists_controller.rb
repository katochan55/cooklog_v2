class ListsController < ApplicationController
  before_action :logged_in_user

  def index
    @lists = current_user.lists
    @log = Log.new
  end

  def create
    @dish = Dish.find(params[:dish_id])
    @user = @dish.user
    current_user.list(@dish)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    list = List.find(params[:list_id])
    @dish = list.dish
    list.destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
