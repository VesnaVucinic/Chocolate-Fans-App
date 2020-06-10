class UsersController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
          @user.save #if I can save user which means user is valid then we sign up user and redirect to his page show
          session[:user_id] = @user.id #sign up - log in user
          redirect_to user_path(@user) #his page show
        else
          render :new
        end
    end
    
    def show
        redirect_if_not_logged_in
        @user = User.find_by_id(params[:id]) #difference between find_by don't give error like find, but redirect_to page i want 
    end

    private

    def user_params
      params.require(:user).permit(:username, :email, :password)#we take params and requie object that come through params and permit any other params we want
    #when I permit password I need to include in model has_secure password and uncomment in gemfile gem bcypt otherwise I will get error unknown attribute"password"
    end
end
