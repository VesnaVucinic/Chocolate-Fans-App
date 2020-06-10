Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'# we already have rout post for creating new user in resources :user, benefit is when we render the page again the URL will say sign up, and we have to hijack our form so that it posts to the sign up rout
  delete '/logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create' # where provider sends back responce to app,rout that accepts caalback url,
  # :provider is dinamic url and offer option for  any sort of omniauth, and we have 4 different ortions
  # after they login to GitHub and come backc to me I want them to end up on this URL 
  # the authenticating third-party decides whether the user has passed or failed authentication


  #set up nesed routs doesn't show anything, so technicly seting up doesn't implement 
  #for that we nedd to add in review controller,always controler that is neasted and it's index action

  resources :reviews
  resources :chocolates do #nest my review under chocolate, I want ability to review this chocolate by cliking the link thet will take me to nested rout chocolate/1/review/new
    resources :reviews, only: [:new, :index, :create]#show,edit, destroy and update we don't need them to be nested to access the information about first parametar 
    #when I put many to many relationtip under nested route and when we need to get id from params hush
    #but if we can get id from active rcord relationships we dont need nested rout, chocolate id  will apear in show,edit,update and destroy routs
  end
  resources :brands
  resources :users #we al
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
