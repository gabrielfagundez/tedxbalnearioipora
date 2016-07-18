Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resource :time_tracking,      only: [:show]
  resource :account,            only: [:show, :update]
  resource :profile,            only: [:show]

  resources :clients,           only: [:show, :edit, :update]
  resources :upcoming_events,   only: [:index, :create]
  resources :reports,           only: [:index]
  resources :users do
    member do
      get :summary
    end
  end
  resources :projects do
    resources :story_points,    only: [:create, :destroy]

    member do
      get :team_performance
      get :time_distribution

      get :work_entries, as: 'work_entries'
      get :time_usage
      get :total_time
      get :radar
      get :historical
      get :velocity
      get :favorite
      get :toggl_user_widget
      post :enter_work_entries, as: 'enter_work_entries'
    end
  end

  namespace :api do
    resources :users,           only: [:index]
    resources :projects,        except: [:new, :edit] do
      member do
        post :toggle_fav
      end
    end
    resources :widgets,         only: [:destroy]
    resources :time_categories, except: [:new, :edit]
    resources :time_entries,    except: [:new, :edit] do
      collection do
        get :last_open
      end
      member do
        put :close
        post :continue
      end
    end
  end

end
