require "rails_helper"

feature "Certificate creation" do
  scenario "user creates certificate" do
    visit root_path(as: create(:user))
    click_on "New Certificate"

    attach_file(
      "Banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    fill_in "Title", with: "Mexico tour 2015"
    fill_in "Sub title", with: "sub title section of the page"
    fill_in "Terms", with: "Details html content about the tour"
    fill_in "Expires on", with: "10/11/2016"
    fill_in "Policies", with: "This should be the details policies"
    fill_in "Price", with: 19.99
    click_on "Create"

    expect(page).to have_content("Mexico tour 2015")
    expect(page).to have_content("Pending")
    expect(Certificate.last.banner).not_to be_nil
  end
end
