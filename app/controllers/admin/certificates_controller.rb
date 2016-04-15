class Admin::CertificatesController < ApplicationController
  before_action :require_login
  before_action :require_management_admin

  layout "application.admin"

  def index
    @certificates = Certificate.includes(:company)
  end

  def edit
    certificate
  end

  def update
    if certificate.update(certificate_params)
      redirect_to(
        admin_certificates_path,
        notice: I18n.t("certificate.update.success")
      )

    else
      flash.now[:error] = I18n.t("certificate.update.errors")
      render :edit
    end
  end

  private

  def certificate
    @certificate = Certificate.friendly.find(params[:id])
  end

  def certificate_params
    params.require(:certificate).permit(
      :name, :code_prefix, :price, :expires_in,
      :duration, :global, contents_attributes: [:id, :banner]
    )
  end
end
