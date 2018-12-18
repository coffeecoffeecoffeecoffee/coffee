class Event < ApplicationRecord
  belongs_to :group

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :location, presence: true
  validates :group, presence: true
  validates :foursquare_venue_id, presence: true

  scope :future_or_now, -> { where("end_at >= ?", Time.current).order(:start_at) }
  scope :past, -> { where("end_at < ?", Time.current).order(start_at: :desc) }

  def self.next
    future_or_now.first
  end

  def venue
    Venue.new(foursquare_venue)
  end
end
