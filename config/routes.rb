Rails.application.routes.draw do
  mount SwaggerEngine::Engine, at: '/api-docs', as: 'documentation'

  root to: 'welcome#show'

  resources :users, only: [:new, :create, :show]
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/districts',                      to: 'districts#index'
      get '/demographics/district-in-year',  to: 'demographics/districts#show'
    end
  end
end
