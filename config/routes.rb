Rails.application.routes.draw do
  get 'main/index'
  root to: 'main#index'
  get '/signup', to: 'users#new'
  post '/signup', to: "users#create"
  get '/users/:id/edit', to: 'users#edit'
  get '/profiles/:id', to: 'profile#show'
  get '/profiles/:id', to: 'profile#edit'
  patch '/profiles/:id', to: 'profile#update'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :profiles
  resources :sessions
end
