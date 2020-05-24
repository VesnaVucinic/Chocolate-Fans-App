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
        if params[:provider] == 'github'
            @user = User.create_by_github_omniauth(auth)
            #@user.save
            session[:user_id] = @user.id
            
            redirect_to user_path(@user)
   
        else
            @user = User.find_by(username: params[:user][:username]) 
            
            if @user.try(:authenticate, params[:user][:password])
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                flash[:error] = "Sorry, login info was incorrect. Please try again."
                redirect_to login_path #error page we will rederct becouse it's harder is to guess, harder if your user name isn't persisted when they guess wrong
            end
        end
    end



    private

        def auth
            request.env['omniauth.auth']
        end 

  
end

