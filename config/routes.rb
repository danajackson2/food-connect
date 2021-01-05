Rails.application.routes.draw do
  resources :volunteers, only:[:new, :create, :show, :update, :delete]
  resources :trips, only:[:show, :update]
  resources :logins, only:[:new, :create, :delete]
  root 'application#home'
end
