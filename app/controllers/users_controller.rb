class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save #if I can save user which means user is valid then we sign up user and redirect to his page show
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          render :new
        end
    end
    
    def show
        @user = User.find_by_id(params[:id]) #difference between find_by don't give error like find, but redirect_to page i want
        redirect_to '/' if !@user
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
