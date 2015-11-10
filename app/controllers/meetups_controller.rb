class MeetupsController < ApplicationController
  def nearby
    coord = Coord.new(params[:lat], params[:lon])
    nearby_meetups = Meetup.nearby(coord, distance: 50000).page(params[:page]).per(50)
    render json: nearby_meetups, meta: pagination_meta(nearby_meetups)
  end
end
