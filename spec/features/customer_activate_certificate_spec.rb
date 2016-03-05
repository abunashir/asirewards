require "rails_helper"

feature "Certificate activation" do
  scenario "customer activate using link" do
    certificate = create(:certificate)
    customer = create(:user)

    certificate_kit = create(
      :kit, certificate: certificate, user: customer, used: true
    )

    visit activation_path(certificate_kit.code)

    fill_in "Name", with: "Keith Thomson"
    fill_in "Email", with: customer.email
    fill_in "Phone", with: "012345678910"
    fill_in "Activation code", with: certificate_kit.code
    click_on "Activate"

    expect(page).to have_content("Your certificate has been activated")
    expect(certificate_kit.reload.activated_on).to eq(Time.current.to_date)
    expect(certificate_kit.user.name).to eq("Keith Thomson")
    expect(emailed_addresses).to include(customer.email)
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
