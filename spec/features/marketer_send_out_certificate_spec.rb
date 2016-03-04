require "rails_helper"

feature "Send out certificates" do
  scenario "marketer sendout available certificate" do
    marketer = create(:user, admin: true)
    certificate = create(:certificate, user: marketer)
    distribution = build(:distribution)

    order = create(
      :order,
      certificate: certificate,
      user: marketer,
      quantity: 10
    )

    order.approve

    visit root_path(as: marketer)
    click_on "Distributions"
    click_on "Send certificate"

    select certificate.title, from: "Certificate"
    fill_in "Name", with: distribution.name
    fill_in "Email", with: distribution.email
    click_on "Send certificate"

    expect(page).to have_content(certificate.title)
    expect(page).to have_content(distribution.email)
    expect(page).to have_content("Pending")
    expect(emailed_addresses).to include(distribution.email)
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
