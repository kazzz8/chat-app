Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, onle: [:edit, :update]
  resources :rooms, onle: [:new, :create]
end