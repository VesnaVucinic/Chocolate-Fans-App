Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create' 

  resources :chocolates do
    member do
      get 'longest_title'
    end
  end
 
  resources :reviews
  resources :chocolates do #nest my review under chocolate, I want ability to review this chocolate by cliking the link thet will take me to nested rout chocolate/1/review/new
    resources :reviews, only: [:new, :index, :create]
  end
  resources :brands
  resources :users 
end
