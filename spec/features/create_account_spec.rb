require "rails_helper"

feature "Account creation" do
  scenario "create new account" do
    visit root_path
    click_on "Create new account"

    fill_in "Name", with: "Abu Nashir"
    fill_in "Email", with: "abunashir@gmail.com"
    fill_in "Password", with: "secret_password"
    fill_in "Company", with: "Impact Services"
    click_on "Create"

    expect(page).to have_content("Logout")
    expect(page).to have_content(
      "Congratulations, your account has been created successfully."
    )
  end

  scenario "try to create account with invalid information" do
    visit root_path
    click_on "Create new account"
    click_on "Create"

    expect(page).to have_content("Namecan't be blank")
    expect(page).to have_content("Companycan't be blank")
    expect(page).to have_content("Emailis invalid")
    expect(page).to have_content("Passwordcan't be blank")
  end
end
