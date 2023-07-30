Rails.application.routes.draw do
  devise_for :users
  root to: "messages#index"
  resources :users, onle: [:edit, :update]
end
