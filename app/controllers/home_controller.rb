class HomeController < ApplicationController
  def index
    @reviews = Review.all.order(created_at: :DESC)
    @books = Book.find(@reviews.pluck(:book_id))
    @users = User.find(@reviews.pluck(:user_id))
  end
end
