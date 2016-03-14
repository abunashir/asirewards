class CertificatesController < ApplicationController
  before_action :require_login

  def index
    @certificates = current_user.certificates
  end

  def new
    @certificate = current_user.certificates.new
    @certificate.contents.build
  end

  def create
    @certificate = current_user.certificates.new(certificate_params)

    if @certificate.save
      redirect_to(
        certificate_content_path(@certificate),
        notice: I18n.t("cert.create.success")
      )
    else
      render :new
    end
  end

  private

  def certificate_params
    params.require(:certificate).permit(
      :name, :price, :expires_in, :duration, contents_attributes: [:banner]
    )
  end
end
