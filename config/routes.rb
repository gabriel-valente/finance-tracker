Rails.application.routes.draw do
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  devise_for :users
  root "welcome#index"
  get "portfolio", to: "users#portfolio"
  get "search_stock", to: "stocks#search"
  get "refresh_prices", to: "stocks#refresh"
  get "friends", to: "users#friends"
  get "search_user", to: "users#search"
  get "profile", to: "users#show"
end
