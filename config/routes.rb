Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'articles#index'

  resource :users
  resources :articles
  resource :user_sessions

  get 'register', to: 'users#new', as: :registration
  get 'log-in', to: 'user_sessions#new', as: :log_in
  get 'log-out', to: 'user_sessions#destroy', as: :log_out

end
