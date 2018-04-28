require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_many(:memberships).dependent(:destroy) }
  it { should have_many(:groups).through(:memberships) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:twitter) }
  it { should allow_value([true, false]).for(:admin) }
  it { should_not allow_value(nil).for(:admin) }

  describe '#before_validation' do
    it 'downcases email' do
      user = build(:user, email: 'Email@Example.com')
      user.validate
      expect(user.email).to eq('email@example.com')
    end
  end

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
        email = 'fakeemail@example.com'
        existing_user = create(:user, email: email)
        new_name = 'New Name'
        user = build(:user, name: new_name, email: email)
        auth = twitter_auth_hash_for_user(user)
        User.find_or_create_with_omniauth(auth)
        expect(User.find(existing_user.id).name).to eq(new_name)
      end
    end
  end
end
