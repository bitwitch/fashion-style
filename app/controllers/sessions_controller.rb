class SessionsController < ApplicationController

  def new
  end

  def welcome
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
      redirect_to users_path
    else
      flash.now[:error] = "Invalid Username Or Password!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to welcome_path
  end


end
