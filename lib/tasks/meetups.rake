namespace :meetups do
  desc "Import meetups from meetup.com"
  task import: :environment do
    FetchMeetupsService.new.by_topic("softwaredev")
  end
end
