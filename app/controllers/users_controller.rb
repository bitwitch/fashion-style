class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to users_path
    else
      flash.now[:error] = "Username already exists or Passwords didnt match"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end


end
