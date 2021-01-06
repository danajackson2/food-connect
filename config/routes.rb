Rails.application.routes.draw do
  resources :volunteers, only:[:new, :create, :show, :edit, :update, :destroy]
  resources :trips, only:[:show]
  resources :food_banks, only:[:new, :create, :show]
  patch '/trips/:id', to: 'trips#update', as: 'update_trip'
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  delete '/login', to: 'logins#destroy', as: 'logout'
  root 'application#home'
end
