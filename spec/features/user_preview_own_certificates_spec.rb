require "rails_helper"

feature "Certificate previewing" do
  scenario "user preview his own certificate" do
    user = create(:user)
    certificate = create(:certificate, user: user)

    visit root_path(as: user)
    click_on "Certificates"
    click_on "Preview"

    expect(page).to have_content(certificate.title)
    expect(page).to have_content(certificate.sub_title)
    expect(page).to have_content(certificate.terms)
    expect(page).to have_content(certificate.policies)
  end
end
