require "rails_helper"

feature "Certificate activation" do
  scenario "customer activate using link" do
    customer, certificate_kit = create_certificate_and_customer
    visit activation_path(certificate_kit.code)

    fill_in "activation_user_attributes_name_part_one", with: "Keith"
    fill_in "activation_user_attributes_name_part_two", with: "Thomson"
    fill_in "activation_user_attributes_email", with: customer.email
    fill_in "activation_user_attributes_phone", with: "012345678910"
    click_on "Activate"

    expect_activation_page_to_have(customer, certificate_kit)
  end

  scenario "customer activate onsite" do
    customer, certificate_kit = create_certificate_and_customer
    visit root_path

    fill_in "activation_user_attributes_name_part_one", with: "Keith"
    fill_in "activation_user_attributes_name_part_two", with: "Thomson"
    fill_in "activation_user_attributes_email", with: customer.email
    fill_in "activation_user_attributes_phone", with: "012345678910"
    fill_in "activation_activation_code", with: certificate_kit.activation_code
    click_on "Activate"

    expect_activation_page_to_have(customer, certificate_kit)
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end

  def expect_activation_page_to_have(customer, certificate_kit)
    expect(page).to have_content("Your certificate has been activated")
    expect(certificate_kit.reload.activated_on).to eq(Time.current.to_date)
    expect(certificate_kit.user.name).to eq("Keith Thomson")
    expect(emailed_addresses).to include(customer.email)
  end

  def create_certificate_and_customer
    customer = create(:user)
    certificate_kit = create(
      :kit, certificate: create(:certificate), user: customer, used: true
    )

    [customer, certificate_kit]
  end
end
