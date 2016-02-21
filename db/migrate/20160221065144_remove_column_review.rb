class RemoveColumnReview < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :book_id
    remove_column :reviews, :user_id
  end
end
