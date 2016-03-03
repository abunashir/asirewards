require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe "#status" do
    it "returns pending for the default certificate" do
      certificate = create(:certificate)

      expect(certificate.status).to eq("Pending")
    end
  end

  describe "#create_kit" do
    it "creates unused kit" do
      certificate = create(:certificate)
      certificate.create_kit(number: 10)

      expect(certificate.kits.count).to eq(10)
    end
  end
end
