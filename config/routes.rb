Rails.application.routes.draw do

  root 'pages#home'
  get '/about' => 'pages#about'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  resources :users, only: [:show, :create]
  get '/register' => 'users#new'

  resources :schedules
end
