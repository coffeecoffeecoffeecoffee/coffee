Rails.application.routes.draw do
  root to: 'events#index'

  resources :groups, only: :show do
    get '/ical', to: 'calendars#show'
  end

  namespace :admin do
    root to: 'events#index'

    resources :events
    resources :groups
  end
end
