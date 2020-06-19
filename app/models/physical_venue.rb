class PhysicalVenue < ApplicationRecord
  has_one :event, as: :location, dependent: :destroy

  validates :foursquare_id, presence: true
end
