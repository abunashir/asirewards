require "rails_helper"

describe CertificateSender do
  describe  ".release" do
    it "sends the certificate to the user" do
      certificate = create(:certificate)

      distribution = create(
        :distribution,
        certificate_id: certificate.id,
        sender: certificate.user
      )

      email = CertificateSender.release(distribution.id)

      expect(email.subject).to include("Pack your back, your certificate")
      expect(email.from).to eq(["certificate@asirewards.io"])
      expect(email.body.encoded).to include("To activate the certificate")
      expect(email.attachments.first.filename).to include("certificate.pdf")
    end
  end
end
