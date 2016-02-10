class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
    @review.book_id = params[:book_id]
    @book = Book.find(params[:book_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.save
    if @review.valid?
      render action: :index
    else
      @book = Book.find(params[:book_id])
      render action: :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:book_id, :title, :description)
    end
end
