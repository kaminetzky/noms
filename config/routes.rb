Rails.application.routes.draw do
  root "dashboards#show"

  resources :foods
  resources :meals
end
