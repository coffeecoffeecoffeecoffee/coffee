Rails.application.configure do
  config.generators do |g|
    g.orm :active_record, primary_key_type: :uuid

    g.assets false
    g.helper false
    g.javascripts false
    g.stylesheets false

    g.controller_specs false
    g.request_specs false
    g.routing_specs false
    g.view_specs false
  end
end
