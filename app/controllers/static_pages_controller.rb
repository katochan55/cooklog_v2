class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @log = Log.new
    else
      @user = User.new
    end
  end

  def about
  end

  def terms
  end

  def index
  end
end
