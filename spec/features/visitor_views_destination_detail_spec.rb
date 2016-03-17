require "rails_helper"

feature "Destination details" do
  scenario "visitor views destination detail" do
    destination = create(:destination, name: "Raddission Blu")

    visit root_path
    click_on "View all destinations"
    click_on "more"

    expect(current_path).to eq(destination_path(destination))
    expect(page).to have_content(destination.name)
    expect(page).to have_content(destination.content)
    expect(page).to have_link("Book now")
  end
end
