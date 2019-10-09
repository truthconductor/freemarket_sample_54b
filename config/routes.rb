Rails.application.routes.draw do
  devise_for :users
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
  resources :items, only:[:index, :new, :create, :edit, :update]
  # 商品購入ページ
  get 'transaction/:id', to: 'deals/purchase#check_item', as: :purchase_check_item
end
