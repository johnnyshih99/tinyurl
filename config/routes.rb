Rails.application.routes.draw do
  root 'home#index'

  resources :links, only: [:index, :create]

  get "/:token", to: "links#visit_link"
  get "/:token/info", to: "links#link_info"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end