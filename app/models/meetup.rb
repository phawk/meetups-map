class Meetup < ActiveRecord::Base
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  attr_accessor :target

  def self.nearby(coord, distance: 5000)
    Meetup.where("ST_DWithin(meetups.coords, ST_GeographyFromText('SRID=4326;POINT(:lat :lon)'), :distance)", lat: coord.lat, lon: coord.lon, distance: distance)
  end

  def to_coord
    Coord.new(coords.x, coords.y) unless missing_coordinates?
  end

  private

  def missing_coordinates?
    coords.blank?
  end
end

# Nearby back arse of carrickfergus
# Meetup.nearby(54.731510 , -5.772972, distance: 20000).pluck(:name)

# Nearby castlereagh
# Meetup.nearby(54.574997, -5.893822).pluck(:name)

# Nearby titanic qt
# Meetup.nearby(54.604855 , -5.911374).pluck(:name)
