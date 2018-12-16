require "rails_helper"

FactoryBot.factories.map(&:name).each do |factory|
  describe "The #{factory} factory" do
    it "is valid" do
      expect(build(factory)).to be_valid
    end
  end
end
