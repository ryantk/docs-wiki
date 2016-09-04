class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :user_signed_in?, :current_user


  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= if session[:current_user_id].present?
      User.find_by(id: session[:current_user_id])
    end
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
