Rails.application.routes.draw do
  resources :users
  post '/users/login', to: 'users#login'
  post '/users/token-refresh', to: 'users#refresh'
  resources :todos
end
