Rails.application.routes.draw do
  root 'static_pages#home'
  post    '/login',   to: "sessions#create"
  delete  '/logout',  to: "sessions#destroy"
  resources :users, only: [:show, :create]
  resources :settings, only: :show
  resources :message_cards, only: [:show, :create, :destroy]
end
