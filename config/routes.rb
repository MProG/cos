Rails.application.routes.draw do
  root 'main_pages#index'

  resource :main_pages, only: [:index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
