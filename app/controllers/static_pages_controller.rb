class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      # @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @log = Log.new
      @q = current_user.feed.paginate(page: params[:page], per_page: 5).ransack(params[:q])
      @feed_items = @q.result(distinct: true)
    else
      @user = User.new
    end
  end

  def about
  end

  def terms
  end
end
