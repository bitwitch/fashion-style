class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user 
    User.find(session[:user_id])
  end 

  def login(user)
    session[:user_id] = user.id
    #creates session
  end

  def logged_in?
    !!session[:user_id]
  end

  def logout
    session.delete(:user_id)
  end

end
