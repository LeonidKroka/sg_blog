Rails.application.routes.draw do
  root "posts#index"

  resources :users
  resources :account_activations, only: [:edit]
  resources :posts do
    resources :comments
  end
end
