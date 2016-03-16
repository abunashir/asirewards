require "rails_helper"

describe CertificateDestinations do
  describe "#save" do
    it "assign each destinations to that certificate" do
      5.times { |number| create(:destination) }

      certificate = create(:certificate)
      destinations = Destination.limit(3)

      certificate_destination = CertificateDestinations.new(
        certificate: certificate, destination_ids: destinations.map(&:id)
      )

      certificate_destination.save

      expect(
        certificate.reload.destinations.map(&:id)
      ).to eq(destinations.map(&:id))
    end
  end

  describe "#selectable" do
    it "exclude already exist destination" do
      certificate = create(:certificate)
      destination_one =  create(:destination)
      destination_two = create(:destination)
      destination_three = create(:destination)
      destination_four = create(:destination)

      certificate.destinations << destination_one
      certificate.destinations << destination_three

      certificate_destinations = CertificateDestinations.new(
        certificate: certificate
      )

      expect(
        certificate_destinations.selectable.map(&:id)
      ).to eq([destination_two, destination_four].map(&:id))
    end
  end
end
