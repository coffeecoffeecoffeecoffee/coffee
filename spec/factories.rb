FactoryBot.define do
  factory :event do
    start_at Time.current
    end_at Time.current
    location 'The Mill'
    location_url 'http://www.themillsf.com'
    group

    factory :future_event do
      start_at Time.current.tomorrow
    end

    factory :past_event do
      start_at Time.current.yesterday
    end
  end

  factory :group do
    name 'SF iOS Coffee'
    emoji '☕'
  end
end
