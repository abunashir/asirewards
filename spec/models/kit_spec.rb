require 'rails_helper'

describe Kit do
  describe ".available?" do
    it "returns true where there is some unsued kit" do
      create(:kit)
      expect(Kit.available?).to eq(true)
    end

    it "returns false when there is no unused kit" do
      create(:kit, used: true)
      expect(Kit.available?).to eq(false)
    end
  end

  describe ".available_kit" do
    it "returns the last available kit" do
      _kit_one = create(:kit, used: true)
      kit_two  = create(:kit, used: false)

      expect(Kit.available_kit).to eq(kit_two)
    end
  end

  describe ".generate" do
    it "generate a new kit" do
      certificate = create(:certificate)
      certificate.kits.generate
      kit = certificate.kits.last

      expect(kit.code).not_to be_nil
      expect(kit.code.length).to eq(7)
    end
  end

  describe "#mark_used!" do
    it "marks the kit as used" do
      kit = create(:kit, used: false)
      kit.mark_used!

      expect(kit.used?).to eq(true)
    end
  end
end
