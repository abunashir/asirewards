require "rails_helper"

feature "Certificate previewing" do
  scenario "staff preview certificates" do
    user = create(:user)
    certificate = create(:certificate, company: user.company)

    visit root_path(as: user)
    visit marketer_path

    click_on "Certificates"
    click_on "Preview"

    expect(page).to have_content(certificate.title)
    expect(page).to have_content(certificate.sub_title)
    expect(page).to have_content(certificate.terms)
    expect(page).to have_content(certificate.policies)
  end
end
