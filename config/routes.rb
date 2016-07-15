Rails.application.routes.draw do
  mount SwaggerEngine::Engine, at: '/api-docs', as: 'documentation'

  root to: 'visualization#show'

  resources :users, only: [:new, :create, :show, :update]
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get 'visualization/demographics',          to: 'visualization/demographics#index'
  get 'visualization/graduation',            to: 'visualization/graduation#index'
  get 'visualization',                       to: 'visualization#show'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/districts',                      to: 'districts#index'
      get '/counties',                       to: 'counties#index'
      get '/student_identifiers',            to: 'student_identifiers#index'
      get '/demographics/district-in-year',  to: 'demographics/districts#show'
      get '/demographics/statewide-in-year', to: 'demographics/state#show'
      get '/graduation/district-in-year',    to: 'graduation/districts#show'
      get '/graduation/county-in-year',      to: 'graduation/counties#show'
      get '/graduation/statewide-in-year',   to: 'graduation/state#show'

    end
  end
end
