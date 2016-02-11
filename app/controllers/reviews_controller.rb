class ReviewsController < ApplicationController
  before_filter :login_required

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
      redirect_to books_path
    else
      @book = Book.find(params[:book_id])
      render action: :new
    end
  end

  def edit
    
  end

  def update
  end

  private
    def review_params
      params.require(:review).permit(:book_id, :title, :description)
    end
end
