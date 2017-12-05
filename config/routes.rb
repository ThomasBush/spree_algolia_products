Spree::Core::Engine.add_routes do
  namespace :admin do
    resource :algolia_settings, only: [:show] do
      get 'algolia_settings/runner', action: 'runner', as: 'reindexer'
    end
  end

  namespace :api do
    namespace :v1 do
      get '/products/reindex', to: 'algolia_settings#runner', as: 'reindexer'
    end
  end
end
