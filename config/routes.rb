Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create] do
    resources :messages, only: [:index, :create] #ネストさせることによって、メッセージに紐付いているチャットルームのidという意味になる
  end
end