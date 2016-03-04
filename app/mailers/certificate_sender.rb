class CertificateSender < ApplicationMailer
  default from: "certificate@asirewards.io"

  def release(distribution_id)
    distribution = Distribution.find(distribution_id)
    generator = CertificateGenerator.new(distribution)

    attachments["#{generator.filename}"] = generator.to_pdf

    mail(
      to: distribution.email,
      subject: "Pack your back, your certificate is here"
    )
  end
end
