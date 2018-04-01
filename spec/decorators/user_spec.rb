require 'rails_helper'

describe UserDecorator do
  describe '#avatar_url' do
    it 'generates an avatar url using the Twitter username' do
      user = create(:user, twitter: 'testtwitter').decorate
      expect(user.avatar_url).to eq('https://twitter.com/testtwitter/profile_image?size=original')
    end
  end
end
