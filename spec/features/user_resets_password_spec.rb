require "rails_helper"

feature "Password reset" do
  scenario "user resets their password" do
    user = create(:user, password: "secret_password")

    visit root_path
    click_on "Business Login"
    click_on "Forgot password?"
    fill_in "password_email", with: user.email
    click_on "Submit"

    user.reload
    visit edit_user_password_url(user, token: user.confirmation_token.html_safe)

    fill_in "password_reset_password", with: "new_password"
    click_on "Submit"

    expect(page).to have_link("Logout")
  end
end
