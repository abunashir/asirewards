require "rails_helper"

feature "Send out certificates" do
  scenario "staff sendout available certificate" do
    staff = create(:user, admin: true)
    certificate = create(:certificate, company: staff.company)
    certificate.create_kit(number: 1)
    customer = build(:user, role: "staff")

    visit root_path(as: staff)
    visit marketer_path

    click_on "Certificates"
    click_on "Kits"
    click_on "Send certificate"

    fill_in "Name", with: customer.name
    fill_in "Email", with: customer.email
    click_on "Send certificate"

    expect(page).to have_content(certificate.title)
    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content("Pending")
    expect(emailed_addresses).to include(customer.email)
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
