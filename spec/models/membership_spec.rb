require "rails_helper"

RSpec.describe Membership, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:group) }

  it { is_expected.to allow_value([true, false]).for(:admin) }
  it { is_expected.not_to allow_value(nil).for(:admin) }
end
