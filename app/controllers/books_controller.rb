class BooksController < ApplicationController
  before_action :login_required

  def index
    @user_books = UserBook.includes(:book).includes(:review).where(user_id: current_user.id).order(created_at: :DESC)
  end

  def show
    @book = Book.find(params[:id])
    # @users = User.find(UserBook.where(book_id: @book.id).pluck(:user_id))
    @user_books = @book.user_books.includes(:user, :review)
  end

  def create
    # 重複排除をしなくてはいけない
    searched_book = Book.where(Book.arel_table[:title].matches(book_params[:title])).first

    # TODO トランザクションする必要がある
    if searched_book
      user_book = UserBook.create(user_id: current_user.id, book_id: searched_book.id, have: false)
      Timeline.create(user_book_id: user_book.id, timeline_type: :add_bookshelf)
    else
      book = current_user.books.create(book_params)
      Timeline.create(user_book_id: current_user.user_books.find_by(book_id: book.id).id, timeline_type: :add_bookshelf)
    end

    redirect_to action: :index
  end

  def search
    #　デバックログ出力するために記述
    Amazon::Ecs.debug = true

    @books = []

    # Amazon::Ecs::Responceオブジェクトの取得
    if params[:keyword].present?
      books = Amazon::Ecs.item_search(
        params[:keyword],
        search_index:  'Books',
        dataType: 'script',
        response_group: 'ItemAttributes, Images',
        country:  'jp',
        power: "Not kindle"
      )

      # 本のタイトル,画像URL, 詳細ページURLの取得
      books.items.each do |item|
        book = Book.new(
          title: item.get('ItemAttributes/Title'),
          url: item.get('DetailPageURL'),
          image_url: item.get('MediumImage/URL'),
        )
        @books << book
      end
    end
  end

  private

  def book_params
    permitted_params = params.require(:book).permit(:title, :url, :image_url, :description)
  end
end
