# Preview all emails at http://localhost:3000/rails/mailers/certificate_sender
class CertificateSenderPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/certificate_sender/release
  def release
    CertificateSender.release
  end

end
