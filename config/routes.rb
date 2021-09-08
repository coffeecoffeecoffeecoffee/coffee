Rails.application.routes.draw do
  devise_for :users
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  namespace :api, defaults: { format: :json } do
    resources :groups, only: :index do
      resources :events, only: :index
    end
  end

  namespace :admin do
    root to: "events#index"

    resources :events
    resources :groups
    resources :memberships
    resources :users
  end

  root to: "groups#index"

  post "/auth/:provider/callback", to: "sessions#create"
  get "/auth/:provider/callback", to: "sessions#create"
  get "/auth/failure", to: redirect("/")
  get "/auth/logout", to: "sessions#destroy"

  get "/groups/:id", to: redirect("/%{id}")
  get "/groups/:id/ical", to: redirect("/%{id}/ical")

  resources :groups, only: :index
  resources :groups, path: "", only: :show do
    get "/ical", to: "calendars#show"
  end
end
