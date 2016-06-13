require "rails_helper"

feature "Certificate creation" do
  scenario "admin creates certificate" do
    visit_new_certificate_page
    submit_new_cerficate_form

    certificate = Certificate.last
    create(:content, certificate: certificate)
    click_on "Submit for approval"

    expect(certificate.banner).not_to be_nil
    expect(current_path).to eq(certificates_path)
    expect(page).to have_content("Your certificate has been submitted")
  end

  scenario "admin tries to create invalid certificate" do
    visit_new_certificate_page
    submit_new_cerficate_form
    click_on "Submit for approval"

    expect(page).to have_content("Please use the visual tool (blue pencil")
  end

  def visit_new_certificate_page
    visit root_path(as: create(:user, admin: true))
    visit marketer_path
    click_on "New Certificate"
  end

  def submit_new_cerficate_form
    attach_file(
      "Banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    fill_in "certificate_name", with: "Mexico tour 2015"
    fill_in "certificate_code_prefix", with: "BMM"
    fill_in "certificate_price", with: 19.99
    fill_in "certificate_expires_in", with: 12
    fill_in "certificate_duration", with: 7
    click_on "Create"
  end
end
