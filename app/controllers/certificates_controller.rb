class CertificatesController < ApplicationController
  before_action :require_login

  def index
    @certificates = current_user.certificates
  end

  def new
    @certificate = current_user.certificates.new
  end

  def create
    @certificate = current_user.certificates.new(certificate_params)

    if @certificate.save
      redirect_to certificates_path, notice: I18n.t("cert.create.success")
    else
      render :new
    end
  end

  private

  def certificate_params
    params.require(:certificate).permit(
      :banner, :title, :sub_title, :terms, :policies, :price, :expires_on
    )
  end
end