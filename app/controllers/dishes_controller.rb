class DishesController < ApplicationController
before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]

  def show
    @dish = Dish.find(params[:id])
  end

  def new
    @dish = Dish.new
  end

  def create
    @dish = current_user.dishes.build(dish_params)
    if @dish.save
      flash[:success] = "お料理が登録されました！"
      redirect_to dish_url(@dish)
    else
      @feed_items = []
      render 'dishes/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def dish_params
      params.require(:dish).permit(:name, :discription, :portion, :tips,
                                   :reference, :required_time, :popularity)
    end
end
