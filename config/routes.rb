Rails.application.routes.draw do
  root to: 'home#index'

  namespace :admin do
    resources :events

    root to: 'events#index'
  end
end
