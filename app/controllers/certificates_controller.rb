class CertificatesController < ApplicationController
  before_action :require_login
  before_action :require_staff
  before_action :require_admin, only: [:new, :create]

  def index
    @certificates = sellable_certificates
  end

  def show
    @certificate = Certificate.friendly.find(params[:id])
    render layout: "certificate"
  end

  def new
    @certificate = certificates.new
    @certificate.contents.build
  end

  def create
    @certificate = certificates.new(certificate_params)

    if @certificate.save
      redirect_to certificate_content_path(@certificate)
    else
      render :new
    end
  end

  private

  def certificates
    current_user.company_certificates
  end

  def sellable_certificates
    current_user.company_sellable_certificates
  end

  def certificate_params
    params.require(:certificate).permit(
      :name, :code_prefix, :price, :expires_in, :duration,
      contents_attributes: [:banner]
    )
  end
end
