Rails.application.routes.draw do
  resources :municipes, only: [:index, :new, :edit, :create]
  resources :municipios, only: [:index, :new, :edit, :create]
  resources :enderecos, only: [:new, :create, :edit]

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
