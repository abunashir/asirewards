require "rails_helper"

describe Distribution do
  context ".validations" do
    it { should validate_presence_of :sender }
    it { should validate_presence_of :certificate_id }
    it { should validate_presence_of :kit }
  end

  context "#send_certificate" do
    it "used the unused kit from certificate" do
      certificate, distribution = certificate_with_distribution
      certificate.create_kit(number: 1)

      expect(distribution.send_certificate).to eq(true)
      expect(distribution.kit).not_to be_nil
    end

    it "does not send certificate unless certificate has availabel kits" do
      certificate, distribution = certificate_with_distribution
      certificate.create_kit(number: 1)
      certificate.available_kit.mark_used!

      expect(distribution.send_certificate).to eq(nil)
    end
  end

  context "#status" do
    it "returns pending by default" do
      distribution = create_distribution
      expect(distribution.status).to eq("Pending")
    end

    it "returns activated when distribution was activated" do
      distribution = create_distribution
      distribution.touch :activated_on
      expect(distribution.status).to eq("Activated")
    end
  end

  context "#deliver_certificate" do
    include ActiveJob::TestHelper

    it "enque the certificate sending job" do
      distribution = create_distribution
      distribution.deliver_certificate

      expect(enqueued_jobs.size).to eq(1)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("CertificateSender")
      expect(enqueued_jobs.last[:args].last).to eq(distribution.id)
    end
  end

  private

  def certificate_with_distribution
    certificate = create(:certificate)

    distribution = build(
      :distribution,
      sender: certificate.user,
      certificate_id: certificate.id,
    )

    [certificate, distribution]
  end

  def create_distribution
    _certificate, distribution = certificate_with_distribution
    distribution.save
    distribution
  end
end
