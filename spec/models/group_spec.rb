require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should have_many(:events).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:emoji) }
  it { should validate_presence_of(:slug) }
  it { should validate_presence_of(:time_zone) }
  it { should allow_value('America/New_York').for(:time_zone) }
  it { should_not allow_value('America/New_Yorker').for(:time_zone) }

  it 'generate a new slug when created' do
    group = build(:group, name: 'Slug Group')
    expect(group.slug).to be_nil
    group.save
    expect(group.slug).to eq('slug-group')
  end
end
