Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
  resources :clients, except: [:destroy]
  resources :providers do
    resources :messages, only: %i[new create], controller: :cold_messages
    member do
      delete :delete_image_attachment
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
