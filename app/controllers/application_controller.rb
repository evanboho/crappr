class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper_method :current_user
  # helper_method :signed_in?
   
  # def sign_in(user)
  #     session[:user_id] = user.id
  #     @current_user = user
  #   end
  #   
  #   
  #   def current_user
  #     @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #   end
  #   
  #   def signed_in?  
  #     if 
  #       !current_user.nil?
  #     else
  #       redirect_to users_sign_in_path
  #       flash[:notice] = "please sign in"
  #     end
  #   end
  
end
