class StoresController < ApplicationController
  def nearby
    nearby_stores = Store.nearby(params[:lat].to_f, params[:lon].to_f, distance: 50000)
    render json: nearby_stores
  end
end
