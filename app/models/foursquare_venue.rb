class FoursquareVenue < ApplicationRecord
  has_many :events, as: :location, dependent: :destroy

  validates :foursquare_id, presence: true
end
