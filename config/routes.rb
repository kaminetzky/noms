Rails.application.routes.draw do
  # root "foods#index"

  get "/foods", to: "foods#index"
  get "/foods/:id", to: "foods#show"
end
