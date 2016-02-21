class ReviewsController < ApplicationController
  before_action :login_required

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_book_id = UserBook.find_by(user_id: current_user.id, book_id: book_param[:book_id]).id
    @review.save
    if @review.valid?
      redirect_to books_path
    else
      @book = Book.find(params[:book_id])
      Timeline.create(user_book_id: @review.user_book_id, timeline_type: :create_review)
      render action: :new
    end
  end

  def edit
    @review = Review.find review_id[:id]
    @book = @review.user_book.book
  end

  def update
    review = Review.find(params[:id])
    review.update_attributes(review_params)
    Timeline.create(user_book_id: review.user_book_id, timeline_type: :update_review)
    redirect_to actions: :show
  end

  def show
    @review = Review.find review_id[:id]
    @book = @review.user_book.book
  end

  private
  def review_id
    params.permit(:id)
  end

  def review_params
    params.require(:review).permit(:title, :description)
  end

  def book_param
    params.permit(:book_id)
  end
end
