SurveySystem::Application.routes.draw do

  get "users/new"

  get "users/create"

  # Static pages
  get "home/about"

  # Sessions routes
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  root :to => "home#index"
  resources :users
  resources :sessions
end
