require "rails_helper"

feature "Viewing orders" do
  scenario "admin views order history" do
    marketer = create(:user, role: "staff", admin: true)
    order_one = create(:order, user: marketer)
    order_two = create(
      :order, certificate: create(:certificate, title: "Second Cert")
    )

    visit root_path(as: marketer)
    visit orders_path

    expect(page).to have_content(order_one.certificate.title)
    expect(page).not_to have_content(order_two.certificate.title)
  end
end
