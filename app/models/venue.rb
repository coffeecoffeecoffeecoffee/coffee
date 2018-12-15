class Venue < ApplicationRecord
  has_one :event, dependent: :destroy

  validates :foursquare_id, presence: true
  validates :foursquare_url, presence: true
  validates :name, presence: true
  validates :image_url, presence: true

  def address
    nil
  end
end
