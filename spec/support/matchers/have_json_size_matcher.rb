require "rspec/expectations"

RSpec::Matchers.define :have_json_size do |size|
  match do |response_body|
    JSON(response_body).count == size
  end
end
