class Event < ApplicationRecord
  belongs_to :group

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :location, presence: true
  validates :location_url, presence: true, url: true
  validates :group, presence: true
  validates :venue_foursquare_id, presence: true

  scope :future_or_now, -> { where('end_at >= ?', Time.current).order(:created_at) }

  def self.next
    future_or_now.first
  end
end
