class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :admin, inclusion: { in: [true, false] }
end
