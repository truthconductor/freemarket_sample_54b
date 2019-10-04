Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'joint#index'
  resources :joint, only:[:index]
  resources :items, only:[:index, :new, :create, :edit, :update]
end