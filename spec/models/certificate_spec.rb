require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe "#status" do
    it "returns pending for the default certificate" do
      certificate = create(:certificate)

      expect(certificate.status).to eq("Pending")
    end
  end
end
