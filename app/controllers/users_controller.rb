class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def index
    @users = User.all
  end

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      flash[:error] = "Invalid information, edit the fields below and try again."
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def add_friend
    friend = User.find(params[:friend_id].to_i)
    current_user.friend(friend)
    redirect_to current_user
  end

  def my_friends
    @users = current_user.friends
    render :index
  end

  def unfriend
    current_user.friendships.find { |friendship| friendship.friend_id == params[:friend_id].to_i }.destroy
    redirect_to current_user
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :age, :location, :image, :style_description)
  end

end
