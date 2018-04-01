require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:twitter) }

  describe '.find_or_create_with_omniauth' do
    context 'when the user with that email does not exist' do
      it 'creates and returns the user' do
        expect(User.count).to eq(0)
        auth = twitter_auth_hash_for_user(build(:user))
        User.find_or_create_with_omniauth(auth)
        expect(User.count).to eq(1)
      end
    end

    context 'when the user with that email already exists' do
      it 'finds and returns the user' do
        user = create(:user)
        auth = twitter_auth_hash_for_user(user)
        User.find_or_create_with_omniauth(auth)
        expect(User.count).to eq(1)
      end

      it 'updates the user' do
        existing_user = create(:user)
        new_name = 'New Name'
        user = build(:user, name: new_name)
        auth = twitter_auth_hash_for_user(user)
        User.find_or_create_with_omniauth(auth)
        expect(User.find(existing_user.id).name).to eq(new_name)
      end
    end
  end
end
