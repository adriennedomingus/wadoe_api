Rails.application.routes.draw do
  mount SwaggerEngine::Engine, at: '/api-docs'

  root to: redirect('/api-docs')

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/districts',                           to: 'districts#index'
      get '/demographics/districts/:slug/:year', to: 'demographics/districts#show'
    end
  end
end
