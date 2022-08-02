Rails.application.routes.draw do
  devise_for :users
  root "dashboards#show"

  resources :foods
  resources :meals
end
