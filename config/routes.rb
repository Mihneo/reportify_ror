Rails.application.routes.draw do
  resources :predicts, only: [:index]

  root 'predicts#index'
end
