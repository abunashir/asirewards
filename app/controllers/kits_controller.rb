class KitsController < ApplicationController
  before_action :require_login

  def index
    @kits = certificate.kits.used
  end

  def new
    @kit = certificate.kits.new
    @kit.build_user
  end

  def create
    @kit = certificate.available_kit
    @kit.attributes = kit_params

    if @kit.send_certificate
      @kit.deliver_certificate
      redirect_to certificate_kits_path(certificate)
    else
      render :new
    end
  end

  private

  def certificate
    @certificate ||= Certificate.find(params[:certificate_id])
  end

  def kit_params
    params.require(:kit).permit(
      user_attributes: [:name, :email, :phone]
    )
  end
end
