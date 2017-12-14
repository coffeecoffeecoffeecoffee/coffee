Rails.application.routes.draw do
  root to: 'home#index'

  get 'groups/:group_id/next_event', to: 'events#show'

  namespace :admin do
    root to: 'events#index'

    resources :events
    resources :groups
  end
end
