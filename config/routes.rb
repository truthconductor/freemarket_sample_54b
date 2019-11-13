Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
  } 
  devise_scope :user do
      get 'step1' => 'users/registrations#step1'
      get 'step2' => 'users/registrations#step2'
      get 'step3' => 'users/registrations#step3'
      get 'step4' => 'users/registrations#step4'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :joint,only:[:index]
  root to: 'joint#index'

  # マイページ
  resource :mypage, only:[:show] do
    member do
      # ログアウト画面の表示
      get :logout
    end
    scope module: :mypage do
      namespace :sale do
        resources :selling, only: [:index]
        resources :dealing, only: [:index]
        resources :closed, only: [:index]
      end
      namespace :purchase do
        resources :dealing, only: [:index]
        resources :closed, only: [:index]
      end
      resource :profiles, only:[:new, :create, :edit, :update]
      resource :personals, only:[:edit, :update]
      resources :mypage_payjp_cards, only:[:index, :new, :create, :destroy], path: "cards", as: :cards
    end
  end

  resources :users, only:[:show]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?


  resources :items do

    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'get_deliver_method', defaults: { format: 'json' }
      get 'get_deliver_method_cash_on_delivery', defaults: { format: 'json' }
    end

    member do
      # 商品販売状態の変更
      patch :deactivate
      patch :activate
    end

    # 商品購入ページ
    scope module: :deals do
      resources :purchase, only: [:new, :create], path: 'transaction'
      resources :deals_payjp_cards, only: [:index, :new, :create], path: "transaction/cards", as: :purchase_card
      resources :deals_delivery_addresses, only: [:new, :create, :edit, :update], path: "transaction/delivery_addresses", as: :purchase_delivery_addresses
    end
  end

  namespace :api do
    resources :brands, only: [] do
      collection do
        # ブランドインクリメンタルサーチ
        get 'search', defaults: { format: 'json' }
      end
    end
  end
end
