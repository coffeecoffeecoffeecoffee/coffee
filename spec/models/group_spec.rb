require "rails_helper"

RSpec.describe Group, type: :model do
  it { is_expected.to have_many(:events).dependent(:destroy) }
  it { is_expected.to have_many(:memberships).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:memberships) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_presence_of(:time_zone) }
  it { is_expected.to allow_value("America/New_York").for(:time_zone) }
  it { is_expected.not_to allow_value("America/New_Yorker").for(:time_zone) }

  it "generate a new slug when created" do
    group = build(:group, name: "Slug Group")
    expect(group.slug).to be_nil
    group.save
    expect(group.slug).to eq("slug-group")
  end

  describe "#image_url" do
    it "returns the first event's image_url" do
      group = create(:group)
      past_event = create(:past_event, group: group)
      create(:future_event, group: group, foursquare_venue_data: nil)

      expect(group.image_url).to eq(past_event.image_url)
    end

    it "returns an empty string when a group doesn't have an event" do
      group = build(:group)

      expect(group.image_url).to eq("")
    end
  end
end
