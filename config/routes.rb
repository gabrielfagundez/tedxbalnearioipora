Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :clients
  resources :team_members
  resources :projects do
    member do
      get :work_entries, as: 'work_entries'
    end
  end

end
