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

  def url
    path = Rails.application.routes.url_helpers.group_path(slug)
    base_url = Rails.application.credentials.base_url
    URI.join(base_url, path).to_s
  end

  def image_url
    events.order(:start_at).first.try(:image_url) || ""
  end
end
