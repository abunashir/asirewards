require "rails_helper"

feature "Destination creation" do
  scenario "management admin create new destination" do
    visit root_path(as: create(:admin, company: create(:company, owner: true)))
    click_on "Destinations"
    click_on "Add new destination"

    destination = build(:destination)

    fill_in "destination_name", with: destination.name
    fill_in "destination_content", with: destination.content
    fill_in "destination_location", with: destination.location
    select destination.country, from: "destination_country"

    attach_file(
      "destination_banner",
      File.join(Rails.root, "/spec/factories/files/banner.png")
    )

    click_on "Create"

    expect(page).to have_content(destination.name)
    expect(page).to have_content(destination.content)
  end
end
