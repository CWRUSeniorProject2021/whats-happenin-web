Rails.application.routes.draw do

  devise_for :users
  root to: 'home#index'

  resources :home, only: :index

  # Default to json response format for api requests.
  defaults format: :json do
    # All API routes.
    namespace :api do
      # All API v1 routes.
      namespace :v1 do
        devise_for :users, path_names: { sign_in: :login }
        resources :posts, only: [:index]
      end
    end
  end
end
