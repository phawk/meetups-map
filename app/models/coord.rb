class Coord
  attr_reader :lat, :lon

  def initialize(lat, lon)
    @lat, @lon = lat.to_f, lon.to_f
  end

  def to_geo_point
    #
  end

  def distance_to(coord)
    #
  end
end
