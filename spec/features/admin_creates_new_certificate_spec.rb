require "rails_helper"

feature "Certificate creation" do
  scenario "admin creates certificate" do
    visit root_path(as: create(:user, admin: true))
    visit marketer_path

    click_on "New Certificate"

    attach_file(
      "Banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    fill_in "certificate_name", with: "Mexico tour 2015"
    fill_in "certificate_price", with: 19.99
    fill_in "certificate_expires_in", with: 12
    fill_in "certificate_duration", with: 7
    click_on "Create"

    click_on "Submit for approval"

    expect(page).to have_content("Submit for approval")
    expect(Certificate.last.banner).not_to be_nil
  end
end
