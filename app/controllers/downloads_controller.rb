class DownloadsController < ApplicationController
  before_action :require_login

  def show
    respond_to do |format|
      format.pdf { send_file(
        certificate_generator.to_pdf_file, download_attributes
      ) }
    end
  end

  private

  def certificate
    current_user.certificates.friendly.find(params[:certificate_id])
  end

  def certificate_kit
    certificate.kits.find(params[:kit_id])
  end

  def certificate_generator
    CertificateGenerator.new(certificate_kit)
  end

  def download_attributes
    {
      filename: certificate_generator.filename,
      type: "application/pdf"
    }
  end
end
