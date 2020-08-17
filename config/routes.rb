Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :profiles, only: [ :index, :new, :create, :show, :edit :update ] do
  	resources :bookings, only: [ :new, :create ]
  end
  resources :dashboards do 
  	resources :bookings, only: [ :index ]
  end
  resources :bookings, only: [ :show, :edit, :update ]
end
