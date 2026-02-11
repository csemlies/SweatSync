Rails.application.routes.draw do
  root "pages#home"

  resources :plan_sessions, path: "sessions" do
  resources :busy_blocks, only: [:index, :destroy] do
    collection do
      post :bulk_create

  get  "join", to: "invites#new"
  post "join", to: "invites#create"

     end
  end
end
