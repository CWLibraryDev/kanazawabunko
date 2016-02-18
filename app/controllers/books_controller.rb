class BooksController < ApplicationController
  before_filter :login_required

  def index
    @user_books = UserBook.where(user_id: current_user.id).order(created_at: :DESC)
  end

  def show
    @book = Book.find(params[:id])
    @users = User.find(UserBook.where(book_id: @book.id).pluck(:user_id))
  end

  def create
    # 重複排除をしなくてはいけない
    searched_book = Book.where(Book.arel_table[:title].matches(book[:title])).first

    if searched_book
      UserBook.create(user_id: current_user.id, book_id: searched_book.id, have: false)
    else
      current_user.books.create(book)
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

  def book
    permitted_params = params.require(:book).permit(:title, :url, :image_url, :description)
  end
end
