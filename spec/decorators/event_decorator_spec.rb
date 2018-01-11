require 'rails_helper'

describe EventDecorator do
  describe '#time' do
    it 'returns a formatted time in group time zone' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      group = create(:group, time_zone: 'America/Los_Angeles')
      event = build(:event, group: group, start_at: start_at).decorate
      expect(event.time).to eq('Wednesday, December 13, 2017, 8:30 AM')
    end
  end

  describe '#start_at_local' do
    it 'returns the start time at the group time zone' do
      start_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, start_at: start_at).decorate
      expect(event.start_at_local).to eq('2017-12-13 08:30:00 -0800')
    end
  end

  describe '#end_at_local' do
    it 'returns the end time at the group time zone' do
      end_at = Time.parse('2017-12-13T16:30:00Z').utc
      event = build(:event, end_at: end_at).decorate
      expect(event.end_at_local).to eq('2017-12-13 08:30:00 -0800')
    end
  end
end
