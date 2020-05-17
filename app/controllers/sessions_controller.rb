class SessionsController < ApplicationController

    def welcome
    end

    def destroy
        session.delete(:user_id)#delete is prefered one for sessions , distroy is for deliting objects
        redirect_to '/'
    end
    
    def new
    end

    def create
        #Try to find the user in the system
        @user = User.find_by(username: params[:user][:username]) #find can only with id, find_by better becouse don't throw error
        
        if @user.try(:authenticate, params[:user][:password])#if there is user and authenticate we set up session and log in
            session[:user_id] = @user.id
            redirect_to user_path(@user)
        else
            flash[:error] = "Sorry, login info was incorrect. Please try again."
            redirect_to login_path #error page we will rederct becouse it's harder is to guess, harder if your user name isn't persisted when they guess wrong
        end
    end
  
end

#did we find someone & did they put in the right password?
        #if @user && @user.authenticate(params[:user][:password])like in sinatra
        # try before calling the method it says is my user nill or is my user something if it's nill it will not call authanticate method if it did find the user it will call authanticate
        #if @user && @user.authenticate(password: params[:user][:password])