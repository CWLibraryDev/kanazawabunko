class HomeController < ApplicationController
  def index
    @timelines = Timeline.includes(user_book: [:user, :book]).page(page[:page]).order(created_at: :DESC)
  end

  private

  def page
    params.permit(:page)
  end
end
