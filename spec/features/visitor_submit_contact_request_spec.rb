require "rails_helper"

feature "Contact request" do
  scenario "visitor submit contact request" do
    support_staff = create(:user, role: "support_staff")
    contact = build(:contact)

    visit root_path

    fill_in "contact_name", with: contact.name
    fill_in "contact_email", with: contact.email
    fill_in "contact_message", with: contact.message
    click_on "Send Message"

    expect(page).to have_content("We've received your request")
    expect(email_address).to include(contact.email)
    expect(email_address).to include(support_staff.email)
  end

  def email_address
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
