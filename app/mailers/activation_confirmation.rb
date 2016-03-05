class ActivationConfirmation < ApplicationMailer
  default from: "certificate@asirewards.io"

  def release(kit_id)
    certificate_kit = Kit.find(kit_id)

    mail(
      to: certificate_kit.user.email,
      subject: "Your certificate has been activated"
    )
  end
end
