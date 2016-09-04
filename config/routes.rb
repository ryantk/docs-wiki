Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'articles#index'

  resource :users
  resources :articles

  get 'register', to: 'users#new', as: :registration

end
