class Event < ApplicationRecord
  belongs_to :group

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :location, presence: true
  validates :location_url, presence: true, url: true
  validates :group_id, presence: true

  scope :upcoming, -> { where('start_at >= ?', Time.current).order(:created_at) }

  def self.next
    upcoming.first
  end
end
