Rails.application.routes.draw do
  root to: 'sessions#new'

  get '/signup', to: 'users#new'
  post '/signup', to: "users#create"

  get '/users/:id', to: 'users#show'
  get '/users/:id/edit', to: 'users#edit'
  patch '/users/:id/update', to: 'users#update'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'skills/:id/edit', to: 'skills#edit'
  get 'skills/:id/new', to: 'skills#new'

  resources :users
  resources :sessions
  resources :skills
end
