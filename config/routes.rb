Rails.application.routes.draw do
  resources :predicts, only: [:index, :create]

  root 'predicts#index'
end
