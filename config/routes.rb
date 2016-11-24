Rails.application.routes.draw do
  root 'graph_lists#index'

  resources :graph_lists, only: [:index]
  resources :graphs
  resource :main_pages, only: [:index, :create]
end
