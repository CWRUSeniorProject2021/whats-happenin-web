Rails.application.routes.draw do

  root to: 'home#index'

  resources :home, only: :index

  # All API routes.
  namespace :api do

    # All API v1 routes.
    namespace :v1 do

    end
  end
end
