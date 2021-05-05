Rails.application.routes.draw do
  resources :predicts, only: [:index] do
    post :calculate_and_predict, on: :collection
  end

  get 'show', to: 'predicts#show'

  root 'predicts#index'
end
