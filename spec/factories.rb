FactoryBot.define do
  factory :event do
    start_at Time.current
    end_at Time.current
    location 'The Mill'
    venue_foursquare_id '4feddd79d86cd6f22dc171a9'
    group

    factory :future_event do
      start_at Time.current.tomorrow
      end_at Time.current.tomorrow.tomorrow
    end

    factory :now_event do
      start_at Time.current.yesterday
      end_at Time.current.tomorrow
    end

    factory :past_event do
      start_at Time.current.yesterday.yesterday
      end_at Time.current.yesterday
    end
  end

  factory :group do
    name 'SF iOS Coffee'
    time_zone 'America/Los_Angeles'
  end

  factory :membership do
    user
    group
  end

  factory :user do
    name 'Some Human'
    sequence(:email) { |n| "email#{n}@example.com" }
    twitter 'twitter'
    admin false
  end
end
