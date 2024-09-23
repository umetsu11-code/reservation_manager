Rails.application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :reservations, only: [:index, :new, :create, :show]
  resources :rooms
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
