class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_one :review
  
  has_many :timeline
end
