class Review < ApplicationRecord
  belongs_to :user_book
  validates :title, presence: true
  validates :description, presence: true
end
