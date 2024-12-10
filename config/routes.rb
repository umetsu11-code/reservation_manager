Rails.application.routes.draw do
  # トップページ
  root "home#index"

  # Deviseによるユーザー認証
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Roomsリソース
  resources :rooms do
    collection do
      get :my_rooms # 登録済み施設一覧のルート
    end
    resources :reservations, only: [:new, :create, :index]
  end

  # Reservationsリソース
  resources :reservations, only: [:index, :show, :destroy]

  # プロフィール編集ページ用のルート
  resources :users, only: [] do
    member do
      get :edit_profile  # プロフィール編集ページ
      patch :update_profile # プロフィール更新処理
    end
  end
end