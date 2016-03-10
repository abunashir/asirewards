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

    fill_in "certificate_title", with: "Mexico tour 2015"
    fill_in "certificate_sub_title", with: "sub title section of the page"
    fill_in "certificate_terms", with: "Details html content about the tour"
    fill_in "certificate_expires_on", with: "10/11/2016"
    fill_in "certificate_policies", with: "This should be the details policies"
    fill_in "certificate_price", with: 19.99
    click_on "Create"

    expect(page).to have_content("Mexico tour 2015")
    expect(Certificate.last.banner).not_to be_nil
  end
end
