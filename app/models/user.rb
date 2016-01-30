class User < ApplicationRecord
  def self.form_omniauth(auth)
    User.create(
      google_uid: auth[:uid],
      name: auth[:info][:name],
      email: auth[:info][:email],
      icon_url: auth[:info][:image]
    )
  end
end
