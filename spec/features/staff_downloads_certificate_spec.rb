require "rails_helper"

feature "Downloading certificate" do
  scenario "staff download customer certificates" do
    staff = create(:user)
    customer = create(:user, role: "customer")
    certificate = create(:certificate, company: staff.company)
    create(:content, certificate: certificate)
    certificate.create_kit(number: 5)
    certificate_kit = certificate.available_kit
    customer.kits << certificate_kit
    certificate_kit.update! used: true

    visit root_path(as: staff)
    click_on "Certificates"
    click_on "Send kit"
    click_on "Download"

    expect(content_type).to eq("application/pdf")
    expect(content_disposition).to include("attachment")
    expect(download_filename).to eq("#{certificate.name}.pdf")
    expect(pdf_body).to have_content(certificate.title)
    expect(pdf_body).to have_content(certificate.terms)
    expect(pdf_body).to have_content(certificate_kit.code)
  end

  def content_type
    response_headers["Content-Type"]
  end

  def content_disposition
    response_headers["Content-Disposition"]
  end

  def download_filename
    content_disposition.scan(/filename="(.*)"/).last.first
  end

  def pdf_body
    temp_pdf = Tempfile.new('pdf')
    temp_pdf << page.source.force_encoding('UTF-8')
    reader = PDF::Reader.new(temp_pdf)
    reader.pages.first.text
  end
end
