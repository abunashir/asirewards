class CertificateDestinationsController < ApplicationController
  before_action :require_login
  before_action :require_admin

  def index
    @destinations = certificate.destinations
  end

  def new
    @certificate_destinations = CertificateDestinations.new(
      certificate: certificate
    )
  end

  def create
    @certificate_destinations = CertificateDestinations.new(
      certificate_destination_params.merge(certificate: certificate)
    )

    if @certificate_destinations.save
      redirect_to(
        certificate_destinations_path(certificate),
        notice: I18n.t("certificate_destination.create.success")
      )
    else
      flash.now[:error] = I18n.t("certificate_destination.create.errors")
      render :new
    end
  end

  private

  def certificate
    @certificate = Certificate.friendly.find(params[:certificate_id])
  end

  def certificate_destination_params
    params.require(:certificate_destinations).permit(destination_ids: [])
  end
end
