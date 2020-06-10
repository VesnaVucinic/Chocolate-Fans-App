class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?

    private

    def logged_in?
        !!session[:user_id]
    end
  
    def current_user
        @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
        #find returns error if is passed id that don't exist, find_by returns nill
      #@current user ||= reduces the calls to db by using tehnicque call memoization, first time current user is refernced within a 
      #scope of an instance of application controller this instance variable will be created and assigned if user is found otherwise
      #it'll be nill and that way subsequent call to current user if it's already populated won't hit the db again 
    end

    def redirect_if_not_logged_in
        redirect_to login_path if !logged_in?
    end
end
