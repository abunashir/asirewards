require "rails_helper"

describe CertificateSender do
  describe  ".release" do
    it "sends the certificate to the user" do
      certificate = create(:certificate)
      user = create(:user)

      certificate_kit = create(
        :kit, used: true, certificate: certificate, user: user
      )

      email = CertificateSender.release(certificate_kit.id)

      expect(email.subject).to include("Pack your back, your certificate")
      expect(email.from).to eq(["certificate@asirewards.io"])
      expect(email.to).to include(user.email)
      expect(email.body.encoded).to include("To activate the certificate")
      expect(email.body.encoded).to include("click on this link")

      expect(
        email.attachments.first.filename
      ).to include("#{certificate.title}.pdf")
    end
  end
end
