Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', only: [:index]
      end
      get 'items/find', to: 'items_search#find'
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items#merchant_find'
      end
    end
  end
end
