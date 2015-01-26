class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  private

  #set and return current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user != nil
      if @current_user.admin == true
        session[:admin] = true
      end
    end
    @current_user
  end

  helper_method :admin?
  #return true or false if current user is admin
  def admin?
    if session[:admin] != nil
      if session[:admin] == true
        true
      else
        false
      end
    end
  end

  #if user is not logged in, direct them to login
  def authenticate
    if current_user == nil
      redirect_to login_path
    end
  end

end
