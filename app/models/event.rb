class Event < ApplicationRecord
  belongs_to :group
  belongs_to :location, polymorphic: true

  has_one_attached :image

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :name, presence: true
  validates :group, presence: true
  validates :foursquare_venue_id, presence: true
  validate :end_at_cannot_be_before_start_at

  scope :future_or_now, -> { where("end_at >= ?", Time.current).order(:start_at) }
  scope :past, -> { where("end_at < ?", Time.current).order(start_at: :desc) }
  def self.next
    future_or_now.first
  end

  before_save :ensure_updated_foursquare_venue_data

  def venue
    FoursquareVenue.new(foursquare_venue_data)
  end

  def image_url
    return Rails.application.routes.url_helpers.rails_blob_url(image) if image.attachment

    venue.image_url
  end

  def venue_url
    "https://foursquare.com/v/#{foursquare_venue_id}"
  end

  def formatted_local_time
    start_at_local = start_at.in_time_zone(group.time_zone)
    start_at_local.strftime("%A, %B %e, %Y, %-I:%M %p")
  end

  def location_type_with_underscores
    location_type.underscore
  end

  private

  def end_at_cannot_be_before_start_at
    errors.add(:end_at, "can't be before start at") if end_at && start_at && end_at <= start_at
  end

  def ensure_updated_foursquare_venue_data
    if new_record?
      FoursquareVenueHydrator.run(self)
      return
    end

    return unless foursquare_venue_id_changed?

    self.foursquare_venue_data = nil
    FoursquareVenueHydrator.run(self)
  end
end
