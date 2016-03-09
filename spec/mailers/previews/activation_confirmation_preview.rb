class ActivationConfirmationPreview < ActionMailer::Preview
  def release
    certificate_kit = Kit.used.first
    ActivationConfirmation.release(certificate_kit)
  end
end
