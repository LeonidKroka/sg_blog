Rails.application.routes.draw do
  root "posts#index"

  resources :users

  resources :posts do
    resources :comments
  end
end
