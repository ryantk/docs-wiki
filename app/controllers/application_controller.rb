class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_signed_in?, :current_user


  def user_signed_in?
    !current_user.is_guest?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
    @current_user ||= GuestUser.new
  end

  def sign_in_user(user)
    session[:current_user_id] = user.id
    @current_user = user
  end

  def sign_out_user
    @current_user = nil
    session[:current_user_id] = nil
  end
end
