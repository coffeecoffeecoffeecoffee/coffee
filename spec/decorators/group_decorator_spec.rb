require 'rails_helper'

describe GroupDecorator do
  describe '#name' do
    it 'returns a the name with the emoji appended' do
      group = build(:group).decorate
      expect(group.name).to eq('SF iOS Coffee ☕')
    end
  end
end
