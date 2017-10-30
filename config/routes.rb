Rails.application.routes.draw do
  root 'graph_lists#index'

  resources :graph_lists, only: [:index, :create]
  resources :fourier_graphs, only: [:show]
  resources :graphs
  resources :fourier_graph_data, only: [:show]
  resource :main_pages, only: [:index, :create]
end
