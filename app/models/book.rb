class Book < ApplicationRecord
  has_many :user, through: :user_books
  has_many :user_books
end
