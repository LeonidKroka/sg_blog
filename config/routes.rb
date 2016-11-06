Rails.application.routes.draw do
  root "posts#index"

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    patch :kill, on: :member
  end
  resources :account_activations, only: [:edit]
  resources :posts do
    resources :comments
  end
end
