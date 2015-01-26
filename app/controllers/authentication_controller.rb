class AuthenticationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    #binding.pry
    begin
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Signed in!"
      #binding.pry
    rescue Exception => e
      redirect_to root_url, :notice => e.to_s
    end

  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  def is_admin
    if current_user != nil
      if current_user.admin == true
        session[:admin] = true
      end
    end
  end

end
