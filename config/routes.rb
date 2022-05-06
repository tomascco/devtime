Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    resources :hits, only: :index
  end

  namespace :api do
    resources :hits, only: :create
  end
end
