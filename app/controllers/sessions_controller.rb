class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    user = User.find_by(google_uid: auth[:uid])
    user = User.form_omniauth(auth) unless user

    icon_url = auth[:info][:image]
    user.update(icon_url: icon_url)

    session[:user_id] = user.id
    redirect_to root_path
end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    redirect_to root_path
  end
end
