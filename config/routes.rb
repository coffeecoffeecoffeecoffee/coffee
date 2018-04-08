Rails.application.routes.draw do
  root to: 'groups#index'

  namespace :admin do
    root to: 'events#index'

    resources :events
    resources :groups
  end

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')
  get '/auth/logout', to: 'sessions#destroy'

  get '/groups/:id', to: redirect('/%{id}')
  get '/groups/:id/ical', to: redirect('/%{id}/ical')

  resources :groups, only: :index
  resources :groups, path: '', only: :show do
    get '/ical', to: 'calendars#show'
  end
end
