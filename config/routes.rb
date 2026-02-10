Rails.application.routes.draw do
  root "pages#home"

  resources :plan_sessions, path: "sessions", only: [:new, :create, :show]

  get  "join", to: "invites#new"
  post "join", to: "invites#create"
end
