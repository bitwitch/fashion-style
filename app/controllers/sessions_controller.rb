class SessionsController < ApplicationController

  def new
  end

  def welcome
  end

  def create
    @user = User.find_by(params[:username])
    if @user && @user.authenticate(params[:password])
      login(@user)
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
