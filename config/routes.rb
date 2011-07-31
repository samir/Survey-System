SurveySystem::Application.routes.draw do


  get "users/new"
  get "users/create"

  # Static pages
  get "about"   => "pages#about",   :as => :about
  get "privacy" => "pages#privacy", :as => :privacy
  get "tos"     => "pages#tos",     :as => :tos
  get "faq"     => "pages#faq",     :as => :faq
  get "contact" => "pages#contact", :as => :contact

  # Sessions routes
  get "logout" => "sessions#destroy", :as => "logout"
  match "login" => "sessions#new", :via => [:get, :post], :as => "login"
  get "signup" => "users#new", :as => "signup"

  root :to => "home#index"
  resources :users
  resources :sessions
end
