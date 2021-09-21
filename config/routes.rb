Rails.application.routes.draw do
  #mount_devise_token_auth_for 'User', at: 'api/v1/auth'

  devise_for :users
  root to: 'home#index'

  resources :home, only: :index

  # Default to json response format for api requests.
  defaults format: :json do
    # All API routes.
    namespace :api do
      # All API v1 routes.
      namespace :v1 do
        #devise_for :users, path_names: { sign_in: :login }
        mount_devise_token_auth_for 'User', at: 'auth'
        resources :events, except: [:index] do
          member do
            get :attendees
          end
          collection do
            get :nearby
          end
          resources :comments
        end
      end
    end
  end
end
