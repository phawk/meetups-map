class Coord
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  attr_reader :lat, :lon

  def initialize(lat, lon)
    @lat, @lon = lat.to_f, lon.to_f
  end

  def to_geo_point
    GEO_FACTORY.point(lat, lon)
  end

  def distance_to(coord)
    to_geo_point.distance(coord.to_geo_point)
  end
end
