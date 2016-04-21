Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resource :time_tracking,  only: [:show]
  resource :account,        only: [:show]

  resources :clients
  resources :reports, only: :index
  resources :team_members do
    member do
      get :summary
    end
  end
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

  namespace :api do
    resources :time_entries, except: [:new, :edit] do
      collection do
        get :last
      end
      member do
        put :close
      end
    end
  end

end
