require "rails_helper"

feature "Send out certificates" do
  scenario "staff sendout available certificate" do
    staff, customer, certificate = staff_customer_and_certificate

    visit_sending_certificate_page(as: staff)
    submit_certificate_sending_form(customer)

    expect_certificate_kit_page_to_have(customer, certificate)
    expect(User.find_by_email(customer.email).company).to eq(staff.company)
  end

  scenario "staff sendout global certificate" do
    staff, customer, certificate = staff_customer_and_certificate
    certificate.update! global: true, company: create(:company)

    visit_sending_certificate_page(as: staff)
    submit_certificate_sending_form(customer)

    expect_certificate_kit_page_to_have(customer, certificate)
  end

  scenario "staff send out certificate to existing customer" do
    staff, customer, certificate = staff_customer_and_certificate
    customer.save

    visit_sending_certificate_page(as: staff)
    submit_certificate_sending_form(customer)

    expect_certificate_kit_page_to_have(customer, certificate)
  end

  scenario "staff try to send certificate to invalid customer" do
    staff, _customer, _certificate = staff_customer_and_certificate
    visit_sending_certificate_page(as: staff)
    click_on "Send certificate"

    expect(page).to have_content("can't be blank")
    expect(page).to have_content("is invalid")
  end

  def staff_customer_and_certificate
    staff = create(:user, admin: true)
    certificate = create(:certificate, company: staff.company)
    certificate.create_kit(number: 1)
    customer = build(:user, role: "staff")

    [staff, customer, certificate]
  end

  def visit_sending_certificate_page(as:)
    visit root_path(as: as)
    visit marketer_path

    click_on "Certificates"
    click_on "Send kit"
    click_on "Send certificate"
  end

  def submit_certificate_sending_form(customer)
    fill_in "Full Name *", with: customer.name
    fill_in "Email Address *", with: customer.email
    click_on "Send certificate"
  end

  def expect_certificate_kit_page_to_have(customer, certificate)
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
