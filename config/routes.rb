Rails.application.routes.draw do
  get 'static/terms_of_service'
  get 'static/privacy_policy'
  
  resources :services
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
  namespace :admin do
    resources :clients
    resources :conversations
    resources :likes
    resources :messages
    resources :notifications
    resources :providers
    resources :ratings
    resources :services
    resources :users
    resources :stats, only: [:index]
    root to: "stats#index"
  end

  resources :clients, except: [:destroy]
  resources :providers do
    resource :like, controller: :likes
    resources :ratings, controller: :ratings
    # resource :payments, controller: :payments
    resources :messages, only: %i[new create], controller: :cold_messages
    member do
      delete :delete_image_attachment
    end
    member do
      get "/pay", to: "payments#pay"
      get "/callback", to: "payments#callback"
    end
    collection do
      get :all, to: "providers#all"
    end
  end
  resources :conversations do
    resources :messages
  end
  resources :notifications, only: %i[index show] do
    collection do
      post "/mark_as_read", to: "notifications#read_all", as: :read
    end
  end
  root "home#index"
end
