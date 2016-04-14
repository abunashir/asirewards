require "rails_helper"

feature "Order certificate kits" do
  scenario "admin orders certificate kits" do
    certificate = vist_new_certificate_kit_order_page
    submit_new_certificate_kit_order_form(certificate)

    expect_orders_page_to_have_order_details(certificate)
  end

  scenario "admin can order global certificate" do
    certificate = create(:certificate, name: "Global Cert", global: true)
    vist_new_certificate_kit_order_page
    submit_new_certificate_kit_order_form(certificate)

    expect_orders_page_to_have_order_details(certificate)
  end

  scenario "try to order with invalid information" do
    vist_new_certificate_kit_order_page
    click_on "Create"

    expect(page).to have_content("Certificatecan't be blank")
  end

  def vist_new_certificate_kit_order_page
    admin = create(:user, admin: true)
    certificate = create(:certificate, company: admin.company)

    visit root_path(as: admin)
    visit marketer_path

    click_on "Orders"
    click_on "Add new order"

    certificate
  end

  def submit_new_certificate_kit_order_form(certificate)
    select certificate.name, from: "order_certificate_id"
    fill_in "order_quantity", with: 20
    fill_in "order_note", with: "This is special note"
    click_on "Create"
  end

  def expect_orders_page_to_have_order_details(certificate)
    expect(page).to have_content(certificate.name)
    expect(page).to have_content(20)
    expect(page).to have_content("Pending")
  end
end
