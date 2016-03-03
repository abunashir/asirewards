require "rails_helper"

describe KitGenerator do
  describe "#code" do
    it "returns an unique code of the given length" do
      kit_generator = KitGenerator.new(length: 7)

      expect(kit_generator.code).not_to be_nil
      expect(kit_generator.code.length).to eq(7)
    end
  end
end
