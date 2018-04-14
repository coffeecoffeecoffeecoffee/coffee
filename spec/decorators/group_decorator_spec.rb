require 'rails_helper'

describe GroupDecorator do
  describe '#image_url' do
    context 'when the group has an event' do
      it 'returns the first event\'s image url', vcr: { cassette_name: :foursquare_venue_details } do
        event = create(:event)
        group = event.group.decorate
        expect(group.image_url).to eq('https://igx.4sqi.net/img/general/612x612/403777_tR60tUZMVoJ5Q5ylr8hQnp0pgZTy5BOQLqydzAoHWiA.jpg')
      end
    end

    context 'when the group has no events' do
      it 'returns nil' do
        group = build(:group).decorate
        expect(group.image_url).to be_nil
      end
    end
  end
end
