class MeetupSerializer < ActiveModel::Serializer
  attributes :id, :name, :urlname, :category, :who, :meetup_id, :city, :country, :link, :rating, :photo, :organizer_name, :members_count, :latitude, :longitude, :distance_to_target

  def distance_to_target
    if object.target.present?
      object.to_coord.distance_to(object.target)
    end
  end

  def latitude
    object.coords.y
  end

  def longitude
    object.coords.x
  end
end
