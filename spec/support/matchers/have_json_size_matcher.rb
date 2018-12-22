require "rspec/expectations"

RSpec::Matchers.define :have_json_size do |size|
  match do |response|
    JSON(response.body).count == size
  end
end
