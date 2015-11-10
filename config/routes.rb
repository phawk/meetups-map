Rails.application.routes.draw do
  root 'home#index'

  get "/meetups/nearby", controller: :meetups, action: :nearby
end
