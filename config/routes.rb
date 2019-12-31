Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resource :password, only: [ :show, :edit, :update ]
      resources :customers
      resources :programs do
        resources :entries, only: [] do
          patch :update_all, on: :collection
        end
      end
      resources :messages, only: [] do
        get :count, on: :collection
      end
      resources :messages, only: [ :index, :show, :destroy ] do
        get :inbound, :outbound, :deleted, :count, on: :collection
        post :tag, on: :member
        delete :tag, on: :member
        resource :reply, only: [ :new, :create ] do
          post :confirm
        end
      end
      resources :tags, only: [] do
        resources :messages, only: [ :index ] do
          get :inbound, :outbound, :deleted, on: :collection
        end
      end
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members do
        resources :staff_events, only: [ :index ]
      end
      resources :staff_events, only: [ :index ]
      resources :allowed_sources, only: [ :index, :create ] do
        delete :delete, on: :collection
      end
    end
  end

  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, except: [ :new, :create, :destroy ] do
        patch :confirm
      end
      resources :programs, only: [ :index, :show ] do
        resource :entry, only: [ :create ] do
          patch :cancel
        end
      end
      resources :messages, except: [ :edit, :update ] do
        post :confirm, on: :collection
      end
    end
  end
end
