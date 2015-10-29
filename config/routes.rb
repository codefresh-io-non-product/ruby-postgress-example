Rails.application.routes.draw do
  resources :articles
  root to: 'visitors#index'
end
