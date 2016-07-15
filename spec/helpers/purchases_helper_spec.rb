require "rails_helper"

describe PurchasesHelper do
  describe "certificate_retail_price" do
    it "returns the certificate retail price with unit" do
      certificate = create(:certificate, price: 30)

      expect(certificate_retail_price(certificate.slug)).to eq("$30")
    end
  end
end
