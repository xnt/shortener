Rails.application.routes.draw do
  resources :links, only: [:show, :create, :index]
  match "*path", to: "links#show", via: :all
end