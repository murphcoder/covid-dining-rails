Rails.application.routes.draw do
  root to: 'restaurants#index'
  resources :reviews
  resources :restaurants do
    resources :reviews
  end
  resources :users do
    resources :reviews
  end
  get '/signin', to: 'sessions#new'
  get '/auth/facebook/callback', to: 'sessions#facebook_create'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  post '/admin_update', to: 'users#admin_update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
