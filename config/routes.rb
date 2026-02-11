Rails.application.routes.draw do
  root "pages#home"

  # join via invite token
  get  "join", to: "invites#new"
  post "join", to: "invites#create"

  # sessions (PlanSession)
  resources :plan_sessions, path: "sessions" do
    # busy blocks calendar + bulk save + delete
    resources :busy_blocks, only: [:new, :create, :destroy] do
      collection do
        post :bulk_create
      end
    end
  end
end
