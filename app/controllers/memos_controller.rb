class MemosController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @user = User.find(@dish.user_id)
    @memo = @dish.memos.build(user_id: current_user.id, content: params[:memo][:content])
    if !@dish.nil? && @memo.save
      flash[:success] = "メモを追加しました！"
      @user.notifications.create(dish_id: @dish.id, variety: 2) # コメントは通知種別2
      $NOTIFICATION_FLAG = 1
    else
      flash[:danger]  = "空のメモは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @memo = Memo.find(params[:id])
    @dish = Dish.find(@memo.dish_id)
    if current_user.id == @memo.user_id
      @memo.destroy
      flash[:success] = "メモを削除しました"
    end
    redirect_to dish_url(@dish)
  end
end
