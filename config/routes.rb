Rails.application.routes.draw do
  resources :clients
  resources :providers do
    member do
      delete :delete_image_attachment
    end
  end
  devise_for :users,  controllers: { registrations: 'users/registrations' , sessions: 'users/sessions'}
  root'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
