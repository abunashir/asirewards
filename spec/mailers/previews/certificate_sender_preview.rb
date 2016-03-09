class CertificateSenderPreview < ActionMailer::Preview
  def release
    certificate_kit = Kit.used.first
    CertificateSender.release(certificate_kit)
  end
end
