class MeetupSerializer < ActiveModel::Serializer
  attributes :id, :name, :urlname, :category, :who, :meetup_id, :city, :country, :link, :rating, :photo, :organizer_name, :members_count, :latitude, :longitude

  def latitude
    object.coords.x
  end

  def longitude
    object.coords.y
  end
end
