Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'test#index'

  get 'mypage', to: 'users#mypage', as: :mypage
  get 'mypage/cards/', to: 'payjp_cards#index', as: :mypage_cards
  get 'mypage/cards/create', to: 'payjp_cards#new', as: :mypage_cards_add
  post 'mypage/cards/', to: 'payjp_cards#create', as: :mypage_cards_create
  delete 'mypage/cards/:id', to: 'payjp_cards#destroy', as: :mypage_cards_destroy
end
