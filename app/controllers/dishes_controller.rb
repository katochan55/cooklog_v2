class DishesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @log = Log.new
  end

  def show
    @dish = Dish.find(params[:id])
    @memo = Memo.new
    @log = Log.new
  end

  def new
    @dish = Dish.new
    @dish.ingredients.build
    # @dish.ingredients.each do |i|
    #   i.build unless i.name.empty?
    # end
  end

  def create
    @dish = current_user.dishes.build(dish_params)
    @memo = Memo.new
    if @dish.save
      flash[:success] = "お料理が登録されました！"
      Log.create(dish_id: @dish.id, content: @dish.cook_memo)
      redirect_to dish_url(@dish)
    else
      render 'dishes/new'
    end
  end

  def edit
    @dish = Dish.find(params[:id])
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(dish_params)
      flash[:success] = "お料理情報が更新されました！"
      redirect_to @dish
    else
      render 'edit'
    end
  end

  def destroy
    @dish.destroy
    flash[:success] = "お料理が削除されました"
    redirect_to request.referrer == user_url(@dish.user) ? user_url(@dish.user) : root_url
  end

  private

    def dish_params
      params.require(:dish).permit(:name, :description, :portion, :tips,
                                   :reference, :required_time, :popularity, :picture, :cook_memo,
                                   ingredients_attributes: [:id, :name, :quantity])
    end

    def correct_user
      # 現在のユーザーが削除対象の料理を保有しているかどうか確認
      @dish = current_user.dishes.find_by(id: params[:id])
      redirect_to root_url if @dish.nil?
    end
end
