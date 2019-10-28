class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @dish  = current_user.dishes.build
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
    end
  end

  def about
  end

  def terms
  end
end
