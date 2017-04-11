Rails.application.routes.draw do
  scope "/one" do
  root "posts#index"

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/search',  to: 'posts#searching'
  get '/search',  to: 'posts#search'
  resources :users do
    patch :kill, on: :member
  end
  resources :account_activations, only: [:edit]
  resources :posts do
    resources :comments
  end
  end
end
