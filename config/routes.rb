Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    root 'home#index'

    resources :home, only: :index
    resources :hits, only: :index
  end

  namespace :api do
    resources :hits, only: :create
  end
end
