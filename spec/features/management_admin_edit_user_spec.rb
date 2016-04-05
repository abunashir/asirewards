require "rails_helper"

feature "User editing" do
  scenario "management admin edit existing user" do
    visit root_path(as: create(:admin, company: create(:owner_company)))
    click_on "Dashboard"
    click_on "Users"
    click_on "edit", match: :first

    fill_in "user_name", with: "Kuddus Mia"
    fill_in "user_email", with: "kuddusmia@gmail.com"
    fill_in "user_phone", with: "12345566"
    fill_in "user_password", with: "new_sec_pass"
    click_on "Update"

    expect(page).to have_content("Kuddus Mia")
    expect(page).to have_content("kuddusmia@gmail.com")
  end
end
