class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @dish  = current_user.dishes.build
      if @dish.present?
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      else
        @feed_items = []
      end
    end
  end

  def about
  end

  def terms
  end
end
