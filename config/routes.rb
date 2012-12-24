RecipeApp::Application.routes.draw do

  get "oauths/oauth"
  get "oauths/callback"

  get "logout" => "sessions#destroy", :as => "logout"
  resources :sessions, only: [:new, :create, :destroy]
  get "signin" => "sessions#new", :as => "signin"
#  match '/auth/:provider', to: 'sessions#new'
#  match '/auth/:provider/callback', to: 'sessions#create'
  resources :users 
  
  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  root to: 'recipes#index'

  resources :recipes do
    resources :directions, only: [:index, :create, :update, :destroy]
  end

  resources :favorites, only: [:create, :destroy]

end
