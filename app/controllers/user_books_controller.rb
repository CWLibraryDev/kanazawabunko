class UserBooksController < ApplicationController
  before_action :login_required

  def update
    user_book = UserBook.find user_books_params[:id]

    if user_book.have?
      user_book.update_attributes(have: false)
    else
      user_book.update_attributes(have: true)
      Timeline.create(user_book_id: user_book.id, timeline_type: :allow_lending)
    end
  end

  private

  def user_books_params
    params.permit(:id)
  end
end
