Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions"}
  resources :clients, except: [:destroy]
  resources :providers do
    resources :messages, only: %i[new create], controller: :messages
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

  root "home#index"
end
