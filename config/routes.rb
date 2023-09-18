Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    root "home#index"

    resources :home, only: :index
    resources :hits, only: :index
    resources :appointments, only: [:index, :new, :create, :edit, :update]
    resources :appointment_kinds, only: [:create]
    resource :profile, only: [:show, :update]
  end

  namespace :api do
    resources :hits, only: :create
  end
end
