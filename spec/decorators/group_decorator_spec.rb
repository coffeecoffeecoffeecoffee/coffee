require 'rails_helper'

describe GroupDecorator do
  describe '#name_with_emoji' do
    it 'returns a the name with the emoji appended' do
      group = build(:group).decorate
      expect(group.name_with_emoji).to eq('SF iOS Coffee ☕')
    end
  end
end
