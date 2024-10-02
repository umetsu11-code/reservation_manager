Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :reservations, only: [:index, :new, :create, :show]
  
  resources :rooms do
    resources :reservations, only: [:new, :create, :index]
  end

  resources :facilities

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
