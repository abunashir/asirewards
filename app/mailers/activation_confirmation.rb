class ActivationConfirmation < ApplicationMailer
  default from: "ASI Rewards <certificate@asirewards.io>"

  def release(kit_id)
    @certificate_kit = Kit.find(kit_id)

    mail(
      to: @certificate_kit.user.email,
      subject: "Your certificate has been activated – time to decide where
      you would like to go!"
    )
  end
end
