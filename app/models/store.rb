class Store < ActiveRecord::Base
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

  geocoded_by :street_address do |record, results|
    result = results.first

    fail "Geocoding failed" if result.nil?

    # record.street_address = result.address
    record.lonlat = GEO_FACTORY.point(result.latitude, result.longitude)
  end

  after_validation :geocode, if: :geocoding_neccessary?

  # e.g. Store.nearby(54.574997, -5.893822).pluck(:name)
  def self.nearby(lat, lon, distance: 5000)
    Store.where("ST_Distance(lonlat, ST_GeographyFromText('SRID=4326;POINT(:lat :lon)')) < :distance", lat: lat, lon: lon, distance: distance)
  end

  private

  def geocoding_neccessary?
    if new_record?
      missing_coordinates?
    else
      street_address_changed?
    end
  end

  def missing_coordinates?
    lonlat.blank?
  end
end

# Nearby back arse of carrickfergus
# Store.nearby(54.731510 , -5.772972, distance: 20000).pluck(:name)

# Nearby castlereagh
# Store.nearby(54.574997, -5.893822).pluck(:name)

# Nearby titanic qt
# Store.nearby(54.604855 , -5.911374).pluck(:name)
