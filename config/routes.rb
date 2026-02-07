Rails.application.routes.draw do
  root "pages#home"
  get "join", to: "pages#join"
  get "create", to: "pages#create"
end
