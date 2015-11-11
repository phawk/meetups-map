class Coord
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  attr_reader :lon, :lat

  def initialize(lon, lat)
    @lon, @lat = lon.to_f, lat.to_f
  end

  def to_geo_point
    GEO_FACTORY.point(lon, lat)
  end

  def distance_to(coord)
    to_geo_point.distance(coord.to_geo_point)
  end
end
