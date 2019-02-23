Rails.application.routes.draw do
  config = Rails.application.config.baukis2

  constraints host: config[:staff][:host] do
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, only: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members
    end
  end

  namespace :customer do
    root "top#index"
  end
end
