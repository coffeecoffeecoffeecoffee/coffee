class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  has_one_attached :image

  validates :name, presence: true
  validates :slug, presence: true
  validates :time_zone, presence: true
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.name } }

  scope :active, -> { joins(:events).where("events.end_at >= ?", 30.days.ago).distinct }

  def self.with_member(user)
    Group.joins(:users).where(users: { id: user.id })
  end

  def image_url
    return Rails.application.routes.url_helpers.rails_blob_url(image) if image.attachment

    events.order(:start_at).first.try(:image_url) || ""
  end
end
