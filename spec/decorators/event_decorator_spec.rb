require 'rails_helper'

describe EventDecorator do
  describe '#time' do
    it 'returns a formatted time in US/Pacific' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, start_at: start_at).decorate
      expect(event.time).to eq('Wednesday, December 13, 2017, 8:30 AM')
    end
  end
end
