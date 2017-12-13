class Event < ApplicationRecord
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :location, presence: true
  validates :location_url, presence: true, url: true

  scope :upcoming, -> { where('start_at >= ?', Time.current).order(:created_at) }
  scope :next, -> { upcoming.first }

  def start_at_pacific
    start_at.in_time_zone('US/Pacific')
  end
end
