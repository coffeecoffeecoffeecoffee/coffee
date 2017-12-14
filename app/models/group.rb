class Group < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, presence: true
  validates :emoji, presence: true
end
