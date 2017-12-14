require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:events).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
