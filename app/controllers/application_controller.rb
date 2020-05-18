class ApplicationController < ActionController::Base

    private
  
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id] #will always call db once if I use current_user miore that once
    end
end
