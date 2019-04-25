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

  def url
    Rails.application.routes.url_helpers.group_url(slug)
  end

  def image_url
    return unless image.attachment

    Rails.application.routes.url_helpers.rails_blob_url(image)
  end
end
