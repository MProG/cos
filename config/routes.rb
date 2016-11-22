Rails.application.routes.draw do
  root 'main_pages#index'

  resource :main_pages, only: [:index, :create]
end
