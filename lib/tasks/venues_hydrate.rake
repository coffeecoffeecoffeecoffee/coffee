namespace :venues do
  desc "Hydrate venue data for all unhydrated events"
  task hydrate: :environment do
    Event.where(foursquare_venue_data: nil).each do |event|
      print "Hydrating Venue for Event #{event.id}... "
      EventVenueHydrator.run(event)
      event.save
      puts "done."
    end
  end
end
