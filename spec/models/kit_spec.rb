require 'rails_helper'

RSpec.describe Kit, type: :model do
  describe ".generate" do
    it "generate a new kit" do
      certificate = create(:certificate)
      certificate.kits.generate
      kit = certificate.kits.last

      expect(kit.code).not_to be_nil
      expect(kit.code.length).to eq(7)
    end
  end
end
