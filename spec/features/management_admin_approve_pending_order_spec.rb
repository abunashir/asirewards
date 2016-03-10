require "rails_helper"

feature "Order approval" do
  scenario "management admin approves pending order" do
    order = create(:order)

    visit root_path(as: create(:admin, company: create(:company, owner: true)))
    visit marketer_path

    click_on "Orders"
    click_on "details"
    click_on "Approve"

    expect(page).not_to have_content(order.certificate.name)
    expect(order.certificate.kits.count).to eq(order.quantity)
  end
end