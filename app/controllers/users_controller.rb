class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "クックログへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params_update)
      flash[:success] = "プロフィールが保存されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーの削除に成功しました"
    redirect_to users_url
  end

  private

    # ユーザー新規作成時に許可する属性
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # プロフィール編集時に許可する属性
    def user_params_update
      params.require(:user).permit(:name, :email, :introduction, :sex)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      flash[:danger] = "このページへはアクセスできません"
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者ユーザーかどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
