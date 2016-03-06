class CertificateSender < ApplicationMailer
  default from: "certificate@asirewards.io"

  def release(certificate_kit_id)
    @certificate_kit = Kit.find(certificate_kit_id)
    generator = CertificateGenerator.new(@certificate_kit)

    attachments["#{generator.filename}"] = generator.to_pdf

    mail(
      to: @certificate_kit.user.email,
      subject: "Pack your back, your certificate is here"
    )
  end
end
