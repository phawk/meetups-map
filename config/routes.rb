Rails.application.routes.draw do
  root 'home#index'

  get "/stores/nearby", controller: :stores, action: :nearby
  get "/meetups/nearby", controller: :meetups, action: :nearby
end
