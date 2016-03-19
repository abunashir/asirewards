class CertificatesController < ApplicationController
  before_action :require_login

  def index
    @certificates = certificates
  end

  def show
    @certificate = certificates.find(params[:id])
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
    current_user.certificates
  end

  def certificate_params
    params.require(:certificate).permit(
      :name, :code_prefix, :price, :expires_in, :duration,
      contents_attributes: [:banner]
    )
  end
end
