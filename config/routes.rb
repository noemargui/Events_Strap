Rails.application.routes.draw do
  devise_for :users

  resources :events do
    resources :attendances, only: [:new, :create, :index]
    resources :avatars, only: [:create]
  end
  resources :users do 
    resources :pictures, only: [:create]
  end
  root 'events#index'

  namespace :admin do
     resources :users, :events
     get '/admin', to: 'admins#index'
     root "admins#index"
   end

end
