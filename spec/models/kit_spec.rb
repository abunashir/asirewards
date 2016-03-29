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

  describe ".used" do
    it "scopes the kit to used only" do
      _pending_kit = create(:kit, used: false)
      used_kit  = create(:kit, used: true)

      expect(Kit.used.map(&:id)).to eq([used_kit.id])
    end
  end

  describe ".unused" do
    it "scopes the kit to non used" do
      pending_kit = create(:kit)
      _used_kit  = create(:kit, used: true)

      expect(Kit.unused.map(&:id)).to eq([pending_kit.id])
    end
  end

  describe ".recent" do
    it "order the kits based on last created at" do
      kit_one = create(:kit, created_at: 1.days.ago)
      kit_two = create(:kit)
      kit_three = create(:kit, created_at: 5.days.ago)

      expect(
        Kit.recent.map(&:id)
      ).to eq([kit_two, kit_one, kit_three].map(&:id))
    end
  end

  describe ".activated" do
    it "scoped the kit to activated only" do
      kit_one = create(:kit, used: true, activated_on: 1.days.ago)
      _kit_two = create(:kit)
      kit_three = create(:kit, used: true, activated_on: Time.now)

      expect(Kit.activated.map(&:id)).to eq([kit_one, kit_three].map(&:id))
    end
  end

  describe "#send_certificate" do
    include ActiveJob::TestHelper

    it "mark the kit as used" do
      pending_kit = create(:kit, used: true)

      expect(pending_kit.send_certificate).to eq(true)
      expect(pending_kit.reload.used?).to eq(true)
    end

    it "sends the certificate" do
      certificate = create(:certificate)
      user = create(:user)
      kit = create(:kit, certificate: certificate, user: user)
      kit.send_certificate

      expect(enqueued_jobs.size).to eq(1)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("CertificateSender")
      expect(enqueued_jobs.last[:args].last).to eq(kit.id)
    end
  end

  describe "#status" do
    it "returns proper status for each kit" do
      unused_kit  = create(:kit, used: false)
      pending_kit = create(:kit, used: true, activated_on: nil)
      active_kit  = create(:kit, used: true, activated_on: Time.now)

      expect(unused_kit.status).to eq("Ready")
      expect(pending_kit.status).to eq("Pending")
      expect(active_kit.status).to eq("Activated")
    end
  end

  describe "#activation_code" do
    it "format the kit with certificate prefix" do
      certificate = create(:certificate, code_prefix: "BMM12")
      kit = create(:kit, certificate: certificate)

      expect(kit.activation_code).to eq("BMM12#{kit.code.upcase}")
    end
  end
end
