Rails.application.routes.draw do
  resources :invoice_items
  resources :invoices
  namespace :api do
    namespace :v1 do
      get 'merchants/find_all', to: 'merchants_search#find_all'
      get '/merchants/most_items', to: 'merchants#most_items'
      resources :merchants, only: [:index, :show] do
        resources :items, controller: 'merchant_items', only: [:index]
      end
      get 'items/find', to: 'items_search#find'
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items#merchant_find'
      end
      namespace :revenue do
        resources :merchants, only: [:index, :show]
      end
    end
  end
end
