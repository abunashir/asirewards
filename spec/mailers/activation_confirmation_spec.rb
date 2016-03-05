require "rails_helper"

describe ActivationConfirmation do
  describe ".release" do
    it "sends the confirmation details to the user" do
      certificate_kit = create(
        :kit,
        used: true,
        activated_on: Time.now,
        user: create(:user),
        certificate: create(:certificate)
      )

      email = ActivationConfirmation.release(certificate_kit.id)

      expect(email.subject).to eq("Your certificate has been activated")
      expect(email.from).to eq(["certificate@asirewards.io"])
      expect(email.body.encoded).to include("Next step is to book")
    end
  end
end
