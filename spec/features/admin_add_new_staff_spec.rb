require "rails_helper"

feature "Business staff" do
  scenario "admin add new staff for business" do
    business_admin = create(:user, admin: true)
    visit root_path(as: business_admin)
    click_on "Staff"
    click_on "Add new staff"

    fill_in "user_name", with: "Itje Wylar"
    fill_in "user_email", with: "itje@asirewards.io"
    fill_in "user_phone", with: "01110101010010"
    fill_in "user_password", with: "123456789"
    click_on "Create"

    expect(page).to have_content("Itje Wylar")
    expect(page).to have_content("itje@asirewards.io")
    expect(page).to have_content("Staff")
  end
end
