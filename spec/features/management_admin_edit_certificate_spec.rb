require "rails_helper"

feature "Certificate editing" do
  scenario "management admin edit certificate" do
    content = create(:content, certificate: create(:certificate))
    cert_attr = build(:certificate)

    visit root_path(as: create(:admin, company: create(:owner_company)))
    visit admin_certificates_path
    click_on "edit", match: :first

    attach_file(
      "Banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    fill_in "certificate_name", with: cert_attr.name
    fill_in "certificate_code_prefix", with: cert_attr.code_prefix
    fill_in "certificate_price", with: cert_attr.price
    fill_in "certificate_expires_in", with: 10
    fill_in "certificate_duration", with: 5
    check "Global"
    click_on "Update"

    expect(page).to have_content(cert_attr.name)
    expect(page).to have_content(content.certificate.status)
  end

  scenario "management admin open certificate in edit mode" do
    content = create(:content, certificate: create(:certificate))
    visit root_path(as: create(:admin, company: create(:owner_company)))
    visit admin_certificates_path
    click_on "content"

    expect(current_path).to eq certificate_content_path(content.certificate)
    expect(page).to have_content("Submit for approval")
  end
end
