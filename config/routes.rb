Rails.application.routes.draw do
  root 'static_pages#home'
  get     '/settings', to: "static_pages#settings"
  post    '/login',   to: "sessions#create"
  delete  '/logout',  to: "sessions#destroy"
  resources :users, only: [:show, :create]
end
