Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :profiles, only: [:index, :new, :create, :edit, :update, :show, :destroy] do
    resources :bookings, only: [:index, :new, :create]
  end
  resources :users
  get '/dashboard', to: 'pages#dashboard'
  resources :bookings, only: [:show, :destroy ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
