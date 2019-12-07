class LogsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: :create

  def create
    @dish = Dish.find(params[:dish_id])
    @log = @dish.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "クックログを追加しました！"
    # リスト一覧ページからクックログが作成された場合、その料理をリストから削除
    List.find(params[:list_id]).destroy unless params[:list_id].nil?
    redirect_to dish_path(@dish)
  end

  def destroy
    @log = Log.find(params[:id])
    @dish = @log.dish
    if current_user == @dish.user
      @log.destroy
      flash[:success] = "クックログを削除しました"
    end
    redirect_to dish_url(@dish)
  end

  private

    def correct_user
      # 現在のユーザーが対象の料理を保有しているかどうか確認
      dish = current_user.dishes.find_by(id: params[:dish_id])
      redirect_to root_url if dish.nil?
    end
end
