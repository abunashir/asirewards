require "rails_helper"

feature "Order approval" do
  scenario "admin approves pending order" do
    order = create(:order)

    visit root_path(as: create(:admin))
    visit marketer_path

    click_on "Orders"
    click_on "details"
    click_on "Approve"

    expect(page).not_to have_content(order.certificate.title)
    expect(order.certificate.kits.count).to eq(order.quantity)
  end
end
