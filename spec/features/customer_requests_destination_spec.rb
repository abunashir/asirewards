require "rails_helper"

feature "Book a destination" do
  scenario "customer book a destination" do
    support_staff = create(:user, email: "phluka@gmail.com")
    certificate = create(:certificate)
    customer = create(:user)
    certificate.create_kit(number: 2)
    certificate_kit = certificate.available_kit
    certificate_kit.update user: customer, used: true, activated_on: Time.now

    destination = create(:destination, featured: true)
    certificate.destinations << destination


    visit root_path
    click_on "more"
    click_on "Book now"

    fill_in "booking_confirmation_code", with: certificate_kit.code
    fill_in "booking_check_in", with: 2.days.from_now
    fill_in "booking_adults", with: 2
    fill_in "booking_children", with: 2
    fill_in "booking_contact", with: "0123456789"
    fill_in "booking_note", with: "This is the special note about the booking"
    click_on "Submit"

    expect(page).to have_content("Thank you, we've received your booking")
    expect(emailed_addresses).to include(customer.email)
    expect(emailed_addresses).to include(support_staff.email)
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
