class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def welcome
    end

    def destroy
        session.delete(:user_id)#delete is prefered one for sessions , distroy is for deliting objects, session.clear will remove everything from session
        redirect_to '/'
    end
    
    def new
    end


  # with this route we create something new but not in db but WE ARE CREATIN SESSION WITH THIS ROUT which means we adding key value pair to the session hash
  # the purpose of this route is to receive the login form, find the user, and log the user in (create a session)
    def create
         #I reopen githab and github send me cack code "code"=>"d49c4dda9dbc43d6437d",
        #in console look back: request.env object have the same code
        #request.class gives => ActionDispatch::Request which means that reperesents HTTP request
        #omniouth works like takes token that github gave me "state"=>"2c44090b7f3cbea509bfbe79086da01f0ee499e19967b066" and
        # sends that back to github and github responded with some data about user 
        #and way omniouth works is that store all of the data that github sent me within request which is called omniouth auth hush request.env['omniouth.auth']
        #i go in to my request into enviroment key which is another hash and I am pulling out this key 'omniouth.auth'
        # when github sends me back this code "state"=>"2c44090b7f3cbea509bfbe79086da01f0ee499e19967b066" omniout send tnat code back to github and then github sends me back actual data of person who just authenticate and it puts all in request.env
    #when I pres github login, github send token I send back token to github a get up user info andputs it al in request.env and I know that is info of person just loggedin into github
     #request.env['omniouth.auth']['provider'] >> github
     #request.env['omniouth.auth']['uid'] user id on github
     #if auth.hush = request.env['omniouth.auth']['uid'] #they login via github if diesn't exist they login normaly
        if params[:provider] == 'github'
            #raise auth.inspect
            @user = User.create_by_github_omniauth(auth)
            #@user.save
            session[:user_id] = @user.id
            
            redirect_to user_path(@user)
   
        else
            
            @user = User.find_by(username: params[:user][:username]) 
            # Authenticate the user - verify the user is who they say they are, make sure they are in db
            #did we find someone and did they put right password
            #if @user && @user.authenticate(params[:user][:password])
            if @user.try(:authenticate, params[:user][:password]) # before clling method it check is user nill or something, if user is nill it will not call authenticate     #authenticate return folse for wrong password or whole isntance of user if password is ok vesna.authenticate("vesnica")=>instance of vesna, user itself, whole object which is a truthy value

                session[:user_id] = @user.id
                redirect_to user_path(@user)
            else
                flash[:error] = "Sorry, login info was incorrect. Please try again."
                redirect_to login_path #this is the one error page we will rederct becouse if someone try to gess the information it makes harder if username isn't persisted when they gess wrong, harder if your user name isn't persisted when they guess wrong
            end
        end
    end



    private

        def auth
            request.env['omniauth.auth']
        end 

  
end

