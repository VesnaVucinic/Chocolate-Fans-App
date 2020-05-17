class SessionsController < ApplicationController

    def welcome
    end

    def destroy
        session.delete(:user_id)#delete is prefered one for sessions , distroy is for deliting objects
        redirect_to '/'
    end
    
    def new
    end
end