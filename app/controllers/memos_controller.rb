class MemosController < ApplicationController
  before_action :logged_in_user

  def create
    @dish = Dish.find(params[:dish_id])
    @user = User.find(@dish.user_id)
    @memo = @dish.memos.build(user_id: current_user.id, content: params[:memo][:content])
    if !@dish.nil? && @memo.save
      flash[:success] = "コメントを追加しました！"
      # 自分以外のユーザーからコメントがあったときのみ通知を作成
      if @user != current_user
        @user.notifications.create(dish_id: @dish.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @memo.content) # コメントは通知種別2
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @memo = Memo.find(params[:id])
    @dish = Dish.find(@memo.dish_id)
    if current_user.id == @memo.user_id
      @memo.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to dish_url(@dish)
  end
end
