Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resource :time_tracking,      only: [:show]
  resource :account,            only: [:show, :update]

  resources :clients,           only: [:show, :edit, :update]
  resources :upcoming_events,   only: [:index, :create]
  resources :reports,           only: [:index]
  resources :users do
    member do
      get :summary
    end
  end
  resources :projects,        only: [:index, :show, :edit, :update] do
    resources :story_points,  only: [:create, :destroy]

    member do
      get :velocity
      get :hours
      get :favorite

      get :work_entries, as: 'work_entries'
      post :enter_work_entries, as: 'enter_work_entries'
    end
  end

  # ====== API ======
  namespace :api do
    resources :users,           only: [:index]
    resources :projects,        except: [:new, :edit] do
      member do
        get :time_usage
        get :total_time
        get :radar
        get :historical
        get :velocity
      end
    end
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
