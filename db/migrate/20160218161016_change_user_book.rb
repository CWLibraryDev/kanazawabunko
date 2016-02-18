class ChangeUserBook < ActiveRecord::Migration[5.0]
  def change
    add_column :user_books, :have, :boolean, default: false
  end
end
