Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :joint,only:[:index]
  root to: 'joint#index'

  # マイページ
  resource :mypage, only:[:show] do
    scope module: :mypage do
      resource :profiles, only:[:new, :create, :edit, :update]
      resources :mypage_payjp_cards, only:[:index, :new, :create, :destroy], path: "cards", as: :cards
    end
  end

  resources :users, only:[:show]

  resources :test,only:[:index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :items do
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
end
