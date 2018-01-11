class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :emoji, presence: true
  validates :slug, presence: true
  validates :time_zone, presence: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name } }
end
