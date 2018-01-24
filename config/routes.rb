Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations' }

  # Basic Scaffold
  #resources :payments
  #resources :visits
  #resources :votes
  #resources :quests
  #resources :plates
  #resources :places
  #resources :tokens
  #resources :categories
  #resources :apps
  #resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "web#index"

  namespace :admin do
    resources :payments
    resources :categories
    resources :apps
    resources :users
    resources :visits
    resources :quests
    resources :plates
    resources :places
  end

  #Web App
  get '/places/my', to: 'places#my'
  resources :places do
    resources :plates
    get '/data', to: 'places#data'
  end
  get '/como', to: 'web#how'
  get '/set_location', to: 'web#set_location'
end
