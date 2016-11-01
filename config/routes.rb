Rails.application.routes.draw do
  get 'users/new'

  root "posts#index"
  resources :posts do
    resources :comments
  end
end
