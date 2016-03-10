require "rails_helper"

feature "Order certificate kits" do
  scenario "admin orders certificate kits" do
    certificate = vist_order_new_certificate_kits

    select certificate.name, from: "order_certificate_id"
    fill_in "order_quantity", with: 20
    fill_in "order_note", with: "This is special note"
    click_on "Create"

    expect(page).to have_content(certificate.name)
    expect(page).to have_content(20)
    expect(page).to have_content("Pending")
  end

  scenario "try to order with invalid information" do
    vist_order_new_certificate_kits

    click_on "Create"

    expect(page).to have_content("Certificatecan't be blank")
  end

  def vist_order_new_certificate_kits
    admin = create(:user, admin: true)
    certificate = create(:certificate, company: admin.company)

    visit root_path(as: admin)
    visit marketer_path
    click_on "Orders"
    click_on "Add new order"
    certificate
  end
end
