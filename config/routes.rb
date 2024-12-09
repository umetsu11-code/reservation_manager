Rails.application.routes.draw do
  get 'users/index'
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index" # トップページをhomeコントローラのindexアクションに設定
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}
  resources :users

  resources :rooms do #Reservationモデルの修正を記述
    resources :reservations, only: [:new, :create, :index]
  end
  resources :reservations, only: [:index, :show]

  resources :rooms, only: [:index, :show, :new, :create]
end
