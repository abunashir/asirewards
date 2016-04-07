require "rails_helper"

feature "Certificate destinations" do
  scenario "admin add certificate destinations" do
    admin = create(:user, admin: true)
    create(:certificate, company: admin.company)

    5.times do |number|
      create(:destination, name: "Destination #{number}")
    end

    visit root_path(as: admin)
    click_on "Certificates"

    within("table.certificates") do click_on "Destinations" end
    click_on "Add destinations"

    check "Destination 0"
    check "Destination 2"
    click_on "Save destination"

    expect(page).to have_content("Destination 0")
    expect(page).not_to have_content("Destination 1")
    expect(page).to have_content("Destination 2")
  end
end
