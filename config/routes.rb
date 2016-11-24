Rails.application.routes.draw do
  root 'graph_lists#index'

  resources :graph_lists, only: [:index, :create]
  resources :graphs
  resource :main_pages, only: [:index, :create]
end
