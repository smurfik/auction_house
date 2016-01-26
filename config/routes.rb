Rails.application.routes.draw do

  root to: "maps#index"

  get "/new-user", to: "users#new", as: :new_user
  post "/new-user", to: "users#create"

  get "/sign-out", to: "sessions#sign_out", as: :sign_out
  get "/user-sign-out", to: "users#sign_out"
  get "/user-sign-in", to: "users#sign_in"
  post "/sign-in", to: "sessions#sign_in", as: :sign_in

end
