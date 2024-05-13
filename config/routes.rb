Rails.application.routes.draw do
  get 'main/index'
  root to: 'main#index'
  get '/signup', to: 'users#new'
  post '/signup', to: "users#create"
  get '/users/:id/edit', to: 'users#edit'
  patch '/users/:id/update', to: 'users#update'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'skill/:id/edit', to: 'skill#edit'
  get 'skill/:id/new', to: 'skill#new'
  post '/upload', to: 'users#upload'
  resources :users
  resources :sessions
  resources :skill
end
