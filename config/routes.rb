Rails.application.routes.draw do
  root 'search#show'

  get "search" => "search#index", :as => :search

  resources :items,  only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :users,  only: [:index, :show]
end
