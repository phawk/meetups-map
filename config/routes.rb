Rails.application.routes.draw do
  root 'home#index'

  get "/stores/nearby", controller: :stores, action: :nearby
end
