class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  validates :name, presence: true
  validates :slug, presence: true
  validates :time_zone, presence: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name } }

  def image_url
    events.first.try(:image_url) || ""
  end
end
