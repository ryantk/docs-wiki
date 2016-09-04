class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: auth_params[:username])

    unless @user.present?
      flash.now[:alert] = I18n.t('authentication.failure.no_such_user_with_username', username: auth_params[:username])
      render :new and return
    end

    if @user.authenticate(auth_params[:password])
      sign_in_user(@user)
      redirect_to articles_path, flash: { success: I18n.t('authentication.success') }
    else
      flash.now[:alert] = I18n.t('authentication.failure.incorrect_password')
      render :new
    end

  rescue ActionController::ParameterMissing
    flash.now[:alert] = I18n.t('authentication.failure.missing_data')
    render :new
  end

  private

  def auth_params
    { username: params.fetch(:username), password: params.fetch(:password) }
  end
end
