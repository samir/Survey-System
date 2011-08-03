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
  resources :sessions

  # Surveys routes
  get "surveys/latest"
  get "surveys/public"
  get "surveys/watching"
  get "surveys/answers/:id" => "surveys#answers", :as => "answers"
  post "surveys/set_watching"
  resources :surveys

  # Users routes
  get "users/watchers" => "users#watchers"
  resources :users do 
    get "surveys/:id"         => 'users/surveys#show',   :as => "survey"
    match "surveys/:id/answer"  => 'users/surveys#answer', :as => "survey_answer", :via => [:get, :post]
  end

  root :to => "home#index"
  
end
