class HomeController < ApplicationController
  def index
    @timelines = Timeline.includes(user_book: [:user, :book]).all.order(created_at: :DESC)
  end
end
