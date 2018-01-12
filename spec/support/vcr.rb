require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<FOURSQUARE_CLIENT_ID>') { ENV.fetch('FOURSQUARE_CLIENT_ID') }
  c.filter_sensitive_data('<FOURSQUARE_CLIENT_SECRET>') { ENV.fetch('FOURSQUARE_CLIENT_SECRET') }
end
