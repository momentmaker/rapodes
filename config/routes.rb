Rails.application.routes.draw do
  root "home#index"

  resources :artists, only: [:create]
  resources :odes, only: [:index, :show]
end
