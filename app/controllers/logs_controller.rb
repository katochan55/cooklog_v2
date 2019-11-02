class LogsController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @log = @dish.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "クックログを追加しました！"
    redirect_to request.referrer || root_url
  end

  def destroy
    @log = Log.find(params[:id])
    @dish = Dish.find(@log.dish_id)
    if current_user.id == @log.dish.user_id
      @log.destroy
      flash[:success] = "クックログを削除しました"
    end
    redirect_to dish_url(@dish)
  end
end
