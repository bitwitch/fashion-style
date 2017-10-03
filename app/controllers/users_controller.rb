class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def browse 

  end 

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to browse_path
    else
      flash.now[:error] = "Username already exists or Passwords didnt match"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def require_login
    unless logged_in?
      redirect_to welcome_path 
    end 
  end


end
