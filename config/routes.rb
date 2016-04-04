Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :clients
  resources :projects
  resources :team_members
end
