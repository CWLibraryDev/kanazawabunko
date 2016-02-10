class ReviewsController < ApplicationController
  def index
  end

  def new
    @review = Review.new
    @review.book_id = params[:book_id]
    @book = Book.find(params[:book_id])
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    if review.save
      redirect_to action: :index
    else
      binding.pry
      redirect_to action: :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:book_id, :title, :description)
    end
end
