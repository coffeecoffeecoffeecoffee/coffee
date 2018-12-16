class Venue < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :foursquare_id, presence: true, uniqueness: true

  def address
    nil
  end
end
