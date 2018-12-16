class Venue < ApplicationRecord
  has_many :events

  validates :foursquare_id, presence: true

  def address
    nil
  end
end
