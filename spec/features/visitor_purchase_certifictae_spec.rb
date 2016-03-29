require "rails_helper"

feature "Purchase certificate" do
  scenario "visitor purchase certificate online" do
    create(:certificate, name: "ASI Americas")
    user = build(:user, name_part_one: "Keith", name_part_two: "Thomson")

    visit root_path
    click_on "Buy"
    click_on "Select", match: :first

    stub_create_token_request
    stub_create_payment_request
    stub_find_payment_request("PAY-7KV41762LX957861GK3LMH6A")
    stub_execute_payment_request("PAY-7KV41762LX957861GK3LMH6A")

    fill_in "purchase_user_attributes_name_part_one", with: user.name_part_one
    fill_in "purchase_user_attributes_name_part_two", with: user.name_part_two
    fill_in "purchase_user_attributes_email", with: user.email
    fill_in "purchase_user_attributes_phone", with: user.phone

    click_on "Buy Now"

    expect(page).to have_content("Thank you for your purchase")
    expect(delivered_email.to).to include(user.email)
    expect(delivered_email.subject).to include("Pack your bags")
  end

  def delivered_email
    ActionMailer::Base.deliveries.last
  end
end
