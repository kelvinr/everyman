Rails.application.routes.draw do

  root 'pages#home'
  get '/about' => 'pages#about'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/register' => 'users#new'
  resources :users, only: [:show, :create]

  resources :schedules, only: [:new, :create, :edit, :update]
  resources :experiences, only: [:index, :show, :new, :create, :edit, :update]
end
