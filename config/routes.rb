Rails.application.routes.draw do
  root "home#index"

  resources :odes, only: [:index, :show]
  resources :artists, only: [:create]
end
