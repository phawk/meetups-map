class MeetupsController < ApplicationController
  def nearby
    coord = Coord.new(params[:lon], params[:lat])
    nearby_meetups = Meetup.nearby(coord, distance: 50000).page(params[:page]).per(50)
    nearby_meetups.map do |meetup|
      meetup.target = coord
    end
    render json: nearby_meetups, meta: pagination_meta(nearby_meetups)
  end
end
