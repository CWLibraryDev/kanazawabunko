class Review < ApplicationRecord
  has_one :books

  validates :title, presence: true
  validates :description, presence: true
end
