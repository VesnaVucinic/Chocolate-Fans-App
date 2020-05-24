Rails.application.routes.draw do

  get '/' => 'sessions#welcome'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'# we already have rout post for creating new user in resources :user, benefit is when we render the page again the URL will say sign up, and we have to hijack our form so that it posts to the sign up rout
  delete '/logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create'
  #get '/auth/github/callback' => 'sessions#omniauth'
  #get '/auth/facebook/callback' => 'sessions#create'


  resources :reviews
  resources :chocolates do
    resources :reviews, only: [:new, :index]
  end
  resources :brands
  resources :users #we al
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
