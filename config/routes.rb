Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :clients
  resources :team_members
  resources :users
  resources :projects do
    member do
      get :work_entries, as: 'work_entries'
      get :summary
      get :overview
      get :radar
      get :historical
      get :velocity
      get :favourite
      post :enter_work_entries, as: 'enter_work_entries'
    end
  end

end
