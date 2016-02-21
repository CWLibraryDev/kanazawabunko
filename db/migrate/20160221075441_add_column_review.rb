class AddColumnReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :user_book_id, :integer
  end
end
