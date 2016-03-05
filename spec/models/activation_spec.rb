require "rails_helper"

describe Activation do
  describe ".pending" do
    it "scope kit to pending only" do
      _nonused_kit = create(:kit, used: false)
      pending_kit  = create(:kit, used: true, activated_on: nil)
      _activated_kit = create(:kit, used: true, activated_on: Time.now)

      expect(Activation.pending.map(&:id)).to eq([pending_kit.id])
    end
  end

  describe ".find_by_code" do
    it "finds the kit using activation code" do
      pending_kit = create(:activation, code: "1234ABC")
      expect(Activation.find_by_code("BMM1234ABC")).to eq(pending_kit)
    end
  end

  describe "#activate" do
    it "mark the kit as activated" do
      pending_kit = create(:activation, code: "1234ABC")
      pending_kit.activate

      expect(pending_kit.activated?).to eq(true)
    end
  end

  describe "#deliver_confirmation" do
    include ActiveJob::TestHelper

    it "release the confirmation email" do
      pending_kit = create(:activation, code: "1234ABC")
      pending_kit.activate
      pending_kit.deliver_confirmation

      expect(enqueued_jobs.size).to eq(1)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("ActivationConfirmation")
      expect(enqueued_jobs.last[:args].last).to eq(pending_kit.id)
    end
  end
end
