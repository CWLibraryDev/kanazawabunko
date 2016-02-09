class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
  end
end
