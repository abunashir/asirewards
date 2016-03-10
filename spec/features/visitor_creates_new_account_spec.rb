require "rails_helper"

feature "Account creation" do
  scenario "visitor create new account" do
    visit new_account_path

    fill_in "Full Name", with: "Abu Nashir"
    fill_in "Business Name", with: "Impact Services"
    fill_in "Email Address", with: "abunashir@gmail.com"
    fill_in "Password", with: "secret_password"
    click_on "Create"

    expect(page).to have_content("Logout")
    expect(current_path).to eq(certificates_path)
  end

  scenario "try to create account with invalid information" do
    visit new_account_path
    click_on "Create"

    expect(page).to have_content("Account can't be blank")
    expect(page).to have_content("is invalid")
  end
end
