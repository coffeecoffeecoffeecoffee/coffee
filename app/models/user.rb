class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :hosted_events, class_name: "Event", foreign_key: :host_id, inverse_of: :host, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, case_sensitive: false
  validates :twitter, presence: true
  validates :token, presence: true, uniqueness: true

  after_initialize do
    self.token = SecureRandom.urlsafe_base64
  end

  before_validation do
    self.email = email.try(:downcase)
  end

  def self.find_or_create_with_omniauth(auth)
    email = auth[:info][:email]
    user = User.find_or_initialize_by(email: email)
    user.update(
      email: email,
      name: auth[:info][:name],
      twitter: auth[:info][:nickname]
    )
    user.save!
    user
  end

  def image_url
    "https://twitter.com/#{twitter}/profile_image?size=original"
  end

  def superadmin?
    return true if twitter == "jamescmartinez"

    false
  end
end
