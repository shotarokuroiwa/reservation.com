Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "hotel#index"

  get "/session" => "sessions#new"

  resources :users, only: [ :new, :create, :show, :edit, :update ] do
    member do
      get :edit_account
      get :edit_profile
    end
  end

  resource :account, only: [ :show ], controller: "users"
  resource :session, only: [ :new, :create, :destroy ]

  resources :rooms do
    resource :reservation, only: [ :new, :create ]
  end

  resources :reservations, only: [ :index, :show ]
  resources :searches, only: [ :index ]

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
