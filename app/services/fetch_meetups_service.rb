class FetchMeetupsService
  def initialize
  end

  def by_topic(topic = "softwaredev")
    load_results_by_url("https://api.meetup.com/2/groups?topic=#{topic}&key=#{api_key}")
  end

  def load_results_by_url(url)
    puts "Loading results for URL: #{url}"

    resp = HTTParty.get(url)

    resp["results"].each do |result|
      begin
        # Skip if it exists
        next if Meetup.find_by(meetup_id: result["id"])

        data = {
          name: result["name"],
          urlname: result["urlname"],
          who: result["who"],
          meetup_id: result["id"],
          city: result["city"],
          country: result["country"],
          link: result["link"],
          rating: result["rating"],
          members_count: result["members"],
          coords: Meetup::GEO_FACTORY.point(result["lat"], result["lon"])
        }

        if result["category"]
          data[:category] = result["category"]["name"]
        end

        if result["organizer"]
          data[:organizer_name] = result["organizer"]["name"]
        end

        if result["group_photo"]
          data[:photo] = result["group_photo"]["photo_link"]
        end

        Meetup.create!(data)

        puts "Saved new meetup:#{result["id"]}:#{result["urlname"]}"
      rescue => e
        puts "Encountered an error with meetup:#{result["id"]}:#{result["urlname"]}"
        p e
      end
    end

    if resp["meta"]["next"] && ! resp["meta"]["next"].empty?
      puts "LOAD MORE!\n\n"
      load_results_by_url(resp["meta"]["next"])
    end
  end

  private

  def api_key
    ENV.fetch('MEETUP_API_KEY')
  end
end

# FIELDS
# t.string :name
# t.string :urlname
# t.string :category
# t.string :who
# t.integer :meetup_id
# t.string :city
# t.string :country
# t.string :link
# t.decimal :rating
# t.string :photo
# t.string :organizer_name
# t.integer :members_count
# t.st_point :coords, geographic: true
