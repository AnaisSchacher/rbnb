Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles, only: [ :new, :create, :show, :update ] do
  	resources :bookings, only: [ :new, :create ]
  end
  resources :dashboards do 
  	resources :bookings, only: [ :show, :update ]
  end
end
