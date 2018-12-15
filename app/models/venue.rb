class Venue < ApplicationRecord
  has_one :event, dependent: :destroy

  validates :foursquare_id, presence: true

  def address
    nil
  end
end
