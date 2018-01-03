Rails.application.routes.draw do
  root to: 'events#index'

  resources :groups, path: '', only: :show do
    get '/ical', to: 'calendars#show'
  end

  get '/groups/:id', to: redirect('/%{id}') # rubocop:disable Style/FormatStringToken

  namespace :admin do
    root to: 'events#index'

    resources :events
    resources :groups
  end
end
