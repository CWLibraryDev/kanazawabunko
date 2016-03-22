class RentalRequestsController < ApplicationController
  before_action :login_required

  def index
    @rental_requests = RentalRequest.includes(:user_book).includes(:book).where(user_id: current_user.id).order(created_at: :DESC)
  end

  def new
    @user_book = UserBook.includes(:user).includes(:book).find(user_book[:user_book_id])
    @rental_request = @user_book.rental_request.new(user_id: current_user.id)
  end

  def create
    @rental_request = RentalRequest.create(user_id: current_user.id, user_book_id: user_book[:user_book_id])

    redirect_to action: :index
  end

  private

  def user_book
    params.permit(:user_book_id)
  end
end
