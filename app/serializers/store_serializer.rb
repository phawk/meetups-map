class StoreSerializer < ActiveModel::Serializer
  attributes :id, :name, :street_address, :latitude, :longitude

  def latitude
    object.lonlat.x
  end

  def longitude
    object.lonlat.y
  end
end
