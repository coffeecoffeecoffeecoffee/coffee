require 'rails_helper'

describe EventDecorator do
  describe '#date' do
    it 'returns a formatted date in US/Pacific' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, start_at: start_at).decorate
      expect(event.date).to eq('December 13, 2017')
    end
  end

  describe '#start_time' do
    it 'returns a formatted time in US/Pacific' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, start_at: start_at).decorate
      expect(event.start_time).to eq('8:30AM')
    end
  end
end
