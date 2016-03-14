require "render_anywhere"

class CertificateGenerator
  include RenderAnywhere

  attr_reader :certificate_kit

  def initialize(certificate_kit)
    @certificate_kit = certificate_kit
  end

  def to_pdf
    kit = PDFKit.new(as_html)
    kit.to_pdf
  end

  def to_pdf_file
    kit = PDFKit.new(as_html)
    kit.to_file("tmp/certificate.pdf")
  end

  def filename
    "#{certificate_kit.name}.pdf"
  end

  def render_attributes
    {
      template: "certificates/pdf",
      layout: "certificate_pdf",
      locals: {certificate_kit: certificate_kit}
    }
  end

  private

  def as_html
    render render_attributes
  end
end
