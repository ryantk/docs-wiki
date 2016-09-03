class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user          = User.new
    @user.email    = user_params.fetch(:email)
    @user.username = user_params.fetch(:username)
    @user.password = user_params.fetch(:password)

    unless user_params.fetch(:password) == user_params.fetch(:password_confirmation)
      flash.now[:error] = 'These passwords do not match!'
      render :new and return
    end

    if @user.save
      redirect_to articles_path
    else
      flash.now[:error] = 'Failed to register!'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end

end
