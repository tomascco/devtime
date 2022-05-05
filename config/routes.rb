Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    resources :hits, only: :index

    namespace :api do
      resources :hits, only: :create
    end
  end
end
