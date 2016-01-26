Rails.application.routes.draw do

  root to: "maps#index"

  get "/new-user", to: "users#new", as: :new_user
  post "/new-user", to: "users#create"

  get "/sign-out", to: "sessions#sign_out", as: :sign_out
  post "/sign-in", to: "sessions#sign_in", as: :sign_in

end
