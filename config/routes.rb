Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  resources :profiles, only: [:index, :new, :create, :edit, :update]
  get '/dashboard', to: 'pages#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
