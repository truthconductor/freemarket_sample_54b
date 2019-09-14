Rails.application.routes.draw do
  get 'mypage', to: 'users#mypage', as: :mypage
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'test#index'
end
