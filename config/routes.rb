Rails.application.routes.draw do
  resources :links
  match "*path", to: "links#show", via: :all
end