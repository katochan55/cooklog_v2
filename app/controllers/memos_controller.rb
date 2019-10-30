class MemosController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @user = User.find(@dish.user_id)
    @memo = @dish.memos.build(user_id: current_user.id, content: params[:memo][:content])
    if !@dish.nil? && @memo.save
      flash[:success] = "メモを追加しました！"
      # @user.notifications.create(dish_id: @dish.id,
      #                            content: "あなたの投稿に#{current_user.full_name}さんがコメントしました。")
      # $NOTIFICATION_FLAG = 1
    else
      flash[:danger]  = "空のメモは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    # 料理の投稿者のみ、自由にコメントの削除ができるようにする
  end
end
