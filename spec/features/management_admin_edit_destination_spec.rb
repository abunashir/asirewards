require "rails_helper"

feature "Destinating editing" do
  scenario "management admin edit existing destination" do
    visit root_path(as: create(:admin, company: create(:owner_company)))
    destination = create(:destination)

    click_on "Dashboard"
    click_on "Destinations"
    click_on "edit", match: :first

    fill_in "destination_name", with: "Sheraton"
    fill_in "destination_content", with: "Sheraton details"
    fill_in "destination_location", with: "Bangkok"

    attach_file(
      "destination_banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    click_on "Update"

    expect(page).not_to have_content(destination.name)
    expect(page).to have_content("Sheraton")
  end
end
