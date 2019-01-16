FactoryBot.define do
  factory :event do
    start_at { Time.current }
    end_at { Time.current }
    name { "The Mill" }
    group
    foursquare_venue_id { "4feddd79d86cd6f22dc171a9" }
    foursquare_venue_data do
      # This data is copied from the VCR cassette :foursquare_venue_details
      # It only copies the data we use. There's tons of other data in there.
      {
        id: "4feddd79d86cd6f22dc171a9",
        name: "The Mill", location: {
          formattedAddress: ["736 Divisadero St (btwn Grove St & Fulton St)", "San Francisco, CA 94117", "United States"]
        },
        canonicalUrl: "https://foursquare.com/v/the-mill/4feddd79d86cd6f22dc171a9",
        bestPhoto: {
          prefix: "https://igx.4sqi.net/img/general/",
          suffix: "/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg",
          width: 612,
          height: 612
        }
      }
    end

    factory :future_event do
      start_at { Time.current.tomorrow }
      end_at { Time.current.tomorrow.tomorrow }
    end

    factory :really_future_event do
      start_at { Time.current.tomorrow.tomorrow }
      end_at { Time.current.tomorrow.tomorrow.tomorrow }
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
