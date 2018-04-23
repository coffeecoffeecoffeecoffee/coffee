require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<FOURSQUARE_CLIENT_ID>') { Rails.application.credentials.foursquare[:client_id] }
  c.filter_sensitive_data('<FOURSQUARE_CLIENT_SECRET>') { Rails.application.credentials.foursquare[:client_secret] }
end
