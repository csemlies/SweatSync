Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: "users/registrations",
  sessions: "users/sessions"
}

  # top-level root so root_path exists everywhere
  root to: "pages#home"

  authenticated :user do
    root to: "plan_sessions#index", as: :authenticated_root
  end

  unauthenticated do
    root to: "pages#home", as: :unauthenticated_root
  end

  get '/profile', to: 'users#show', as: :profile

  get "auth_gate", to: "pages#auth_gate", as: :auth_gate

  get  "join", to: "invites#new"
  post "join", to: "invites#create"

  resources :plan_sessions, path: "sessions" do
    get :recommendations, on: :member
    resources :busy_blocks, only: [:new, :create, :destroy] do
      collection do
        post :bulk_create
      end
    end
  end
end
