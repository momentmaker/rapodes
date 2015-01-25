Rails.application.routes.draw do
  root "home#index"

  resources :odes, only: [:index, :show]
end
