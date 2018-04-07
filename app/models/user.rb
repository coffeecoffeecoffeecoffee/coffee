class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :twitter, presence: true

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
end
