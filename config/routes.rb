Rails.application.routes.draw do
  root 'static_pages#home'
  post    '/login',   to: "sessions#create"
  delete  '/logout',  to: "sessions#destroy"
  post    '/card',    to: "message_cards#create"
  resources :users, only: [:show, :create]
  resources :settings, only: :show
end
