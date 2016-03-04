require "render_anywhere"

class CertificateGenerator
  include RenderAnywhere

  attr_reader :certificate

  def initialize(certificate)
    @certificate = certificate
  end

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_pdf
  end

  def filename
    "#{certificate.certificate_title} certificate.pdf"
  end

  def render_attributes
    {
      template: "certificates/pdf",
      layout: "certificate_pdf",
      locals: {distribution: certificate}
    }
  end

  private

  def as_html
    render render_attributes
  end
end
