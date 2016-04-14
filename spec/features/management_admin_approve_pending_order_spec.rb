require "rails_helper"

feature "Order approval" do
  scenario "management admin approves pending order" do
    order = create(:order)

    visit root_path(as: create(:admin, company: create(:owner_company)))
    click_on "Dashboard"
    click_on "Orders"
    click_on "details"
    click_on "Approve"

    expect(page).to have_content(order.certificate.name)
    expect(page).to have_content("Approved")
    expect(order.certificate.kits.count).to eq(order.quantity)
    expect(order.certificate.kits.last.company).not_to be_nil
  end
end
