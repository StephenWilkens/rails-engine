Rails.application.routes.draw do
  resources :items
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
    end
  end
end
