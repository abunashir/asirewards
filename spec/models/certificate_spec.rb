require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe ".global" do
    it "returns the global certs only" do
      _certificate = create(:certificate)
      global_cert = create(:certificate, global: true)

      expect(Certificate.global.last).to eq(global_cert)
    end
  end

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

  describe "#available_kit" do
    it "returns the random available kit" do
      certificate = create(:certificate)
      certificate.create_kit(number: 2)
      certificate.kits.first.update! used: true

      expect(certificate.available_kit).to eq(certificate.kits.last)
    end

    it "does not return kits from different company" do
      certificate = create(:certificate)
      certificate.create_kit(number: 2, business: create(:company))
      certificate.kits.first.update! used: true

      expect(certificate.available_kit).to be_nil
    end
  end

  describe "#number_of_available_kits" do
    it "returns the number of unused kits" do
      certificate = create(:certificate)
      certificate.create_kit(number: 2)
      certificate.kits.first.update! used: true

      expect(certificate.number_of_available_kits).to eq(1)
    end
  end

  describe "#send_certificate" do
    include ActiveJob::TestHelper

    it "creates and send a new certificate" do
      user = create(:user)
      certificate = create(:certificate)
      certificate.send_certificate(user: user)

      expect(enqueued_jobs.size).to eq(1)
      expect(user.kits.last.certificate).to eq(certificate)
      expect(user.kits.last.status).to eq("Pending")
    end
  end

  describe "#publishable?" do
    it "returns true if there is valid content" do
      certificate = create(:certificate)
      create(:content, certificate: certificate)

      expect(certificate.publishable?).to eq(true)
    end

    it "returns false where there is not existing content" do
      certificate = create(:certificate)
      expect(certificate.publishable?).to eq(false)
    end
  end
end
