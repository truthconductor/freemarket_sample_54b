Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :joint,only:[:index]
  root to: 'joint#index'
  get 'mypage', to: 'users#mypage', as: :mypage
  resources :test,only:[:index]
  resources :items, only:[:index, :new, :create, :edit, :update]
end