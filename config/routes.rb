Rails.application.routes.draw do
  # root "foods#index"

  resources :foods
  resources :meals
end
