FactoryBot.define do
  factory :event do
    start_at { Time.current }
    end_at { Time.current }
    location { "The Mill" }
    group
    foursquare_venue_id { "4feddd79d86cd6f22dc171a9" }
    foursquare_venue do
      response_string = VCR::Cassette.new(:foursquare_venue_details).http_interactions.interactions.first.response.body
      body = JSON.parse(response_string, symbolize_names: true)
      body[:response][:venue]
    end

    factory :event_without_foursquare_venue do
      foursquare_venue { nil }
    end

    factory :future_event do
      start_at { Time.current.tomorrow }
      end_at { Time.current.tomorrow.tomorrow }
    end

    factory :now_event do
      start_at { Time.current.yesterday }
      end_at { Time.current.tomorrow }
    end

    factory :past_event do
      start_at { Time.current.yesterday.yesterday }
      end_at { Time.current.yesterday }
    end
  end

  factory :group do
    name { "SF iOS Coffee" }
    time_zone { "America/Los_Angeles" }
  end

  factory :membership do
    user
    group
  end

  factory :user do
    name { "Some Human" }
    email { "example@example.com" }
    twitter { "twitter" }
    admin { false }
  end
end
