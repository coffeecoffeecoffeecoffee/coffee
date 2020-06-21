require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to have_many(:memberships).dependent(:destroy) }
  it { is_expected.to have_many(:groups).through(:memberships) }
  it { is_expected.to have_many(:hosted_events).class_name("Event").with_foreign_key("host_id").inverse_of(:host).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:twitter) }

  describe "#before_validation" do
    it "downcases email" do
      user = build(:user, email: "Email@Example.com")
      user.validate
      expect(user.email).to eq("email@example.com")
    end
  end

  describe ".find_or_create_with_omniauth" do
    context "when the user with that email does not exist" do
      it "creates and returns the user" do
        expect(User.count).to eq(0)
        auth = twitter_auth_hash_for_user(build(:user))
        User.find_or_create_with_omniauth(auth)
        expect(User.count).to eq(1)
      end
    end

    context "when the user with that email already exists" do
      it "finds and returns the user" do
        user = create(:user)
        auth = twitter_auth_hash_for_user(user)
        User.find_or_create_with_omniauth(auth)
        expect(User.count).to eq(1)
      end

      it "updates the user" do
        existing_user = create(:user)
        new_name = "New Name"
        user = build(:user, email: existing_user.email, name: new_name)
        auth = twitter_auth_hash_for_user(user)
        User.find_or_create_with_omniauth(auth)
        expect(User.find(existing_user.id).name).to eq(new_name)
      end
    end
  end

  describe "#image_url" do
    it "returns the user's Twitter image" do
      user = build(:user, twitter: "testtwitter")
      expect(user.image_url).to eq("https://twitter.com/testtwitter/profile_image?size=original")
    end
  end

  describe "#superadmin?" do
    it "returns true if the user is a superadmin" do
      user = build(:user, twitter: "jamescmartinez")
      expect(user).to be_superadmin
    end

    it "returns false if the user is not a superadmin" do
      user = build(:user, twitter: "testtwitter")
      expect(user).not_to be_superadmin
    end
  end
end
