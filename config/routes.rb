Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resource :time_tracking,      only: [:show]
  resource :account,            only: [:show, :update]

  resources :clients
  resources :upcoming_events,   only: [:index, :create]
  resources :reports,           only: [:index]
  resources :users do
    member do
      get :summary
    end
  end
  resources :projects do
    member do
      get :work_entries, as: 'work_entries'
      get :summary
      get :overview
      get :radar
      get :historical
      get :velocity
      get :velocity_entries
      get :favorite
      post :enter_work_entries, as: 'enter_work_entries'
    end
  end

  namespace :api do
    resources :projects, except: [:new, :edit]
    resources :time_categories, except: [:new, :edit]
    resources :time_entries, except: [:new, :edit] do
      collection do
        get :last_open
      end
      member do
        put :close
      end
    end
  end

end
