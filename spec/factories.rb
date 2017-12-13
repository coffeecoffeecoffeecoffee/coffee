FactoryBot.define do
  factory :event do
    start_at Time.current
    end_at Time.current
    location 'Blue Bottle'
    location_url 'https://bluebottlecoffee.com'

    factory :future_event do
      start_at Time.current.tomorrow
    end

    factory :past_event do
      start_at Time.current.yesterday
    end
  end
end
