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
  get 'mypage', to: 'users#mypage', as: :mypage
  get 'mypage/cards/', to: 'users/mypage_payjp_cards#index', as: :mypage_cards
  get 'mypage/cards/create', to: 'users/mypage_payjp_cards#new', as: :mypage_cards_add
  post 'mypage/cards/', to: 'users/mypage_payjp_cards#create', as: :mypage_cards_create
  delete 'mypage/cards/:id', to: 'users/mypage_payjp_cards#destroy', as: :mypage_cards_destroy

  resources :test,only:[:index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :items do
    # 商品購入ページ
    scope module: :deals do
      resources :purchase, only: [:new, :create], path: 'transaction'
      resources :deals_payjp_cards, only: [:index, :new, :create], path: "transaction/cards", as: :purchase_card
      resources :deals_delivery_addresses, only: [:new, :create, :edit, :update], path: "transaction/delivery_addresses", as: :purchase_delivery_addresses
    end
  end
end
