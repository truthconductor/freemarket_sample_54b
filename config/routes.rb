Rails.application.routes.draw do
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :joint,only:[:index]
  root to: 'joint#index'
  resources :test,only:[:index]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
