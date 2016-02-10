class User < ApplicationRecord
  has_many :user_books
  has_many :books, through: :user_books
  has_many :reviews

  def self.form_omniauth(auth)
    User.create(
      google_uid: auth[:uid],
      name: auth[:info][:name],
      email: auth[:info][:email],
      icon_url: auth[:info][:image]
    )
  end
end
