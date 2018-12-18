class Event < ApplicationRecord
  belongs_to :group

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :name, presence: true
  validates :group, presence: true
  validates :foursquare_venue_id, presence: true

  scope :future_or_now, -> { where("end_at >= ?", Time.current).order(:start_at) }
  scope :past, -> { where("end_at < ?", Time.current).order(start_at: :desc) }
  def self.next
    future_or_now.first
  end

  before_save :ensure_updated_foursquare_venue_data

  def venue
    Venue.new(foursquare_venue_data)
  end

  private

  def ensure_updated_foursquare_venue_data
    return unless foursquare_venue_data_changed?
    self.foursquare_venue_data = nil
  end
end
