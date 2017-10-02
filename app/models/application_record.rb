class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

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
