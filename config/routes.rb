Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    root "home#index"

    resources :home, only: :index
    resources :hits, only: :index
    resource :profile, only: :show
  end

  namespace :api do
    resources :hits, only: :create
  end
end
