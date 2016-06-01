Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/districts', to: 'districts#index'
    end
  end
end
