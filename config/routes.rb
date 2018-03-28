Rails.application.routes.draw do
  root to: 'groups#index'

  namespace :admin do
    root to: 'events#index'

    resources :events
    resources :groups
  end

  get '/groups/:id', to: redirect('/%{id}')
  get '/groups/:id/ical', to: redirect('/%{id}/ical')

  resources :groups, path: '', only: %i[index show] do
    get '/ical', to: 'calendars#show'
  end
end
