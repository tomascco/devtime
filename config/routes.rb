Rails.application.routes.draw do
  constraints Rodauth::Rails.authenticated do
    resources :hits
  end
end
