class AuthenticationController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    #binding.pry
    user = User.find_by_provider_and_id(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    #binding.pry

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
