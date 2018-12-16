namespace :venues do
  desc 'Hydrate all unhydrated venues'
  task hydrate: :environment do
    Venue.where(name: nil).each do |venue|
      print "Hydrating Venue #{venue.id}... "
      VenueHydrator.run(venue)
      venue.save
      puts 'done.'
    end
  end
end
