require "rails_helper"

feature "Featured destinations" do
  scenario "visitor view featured destinations" do
    destination_one = create(:destination, featured: false, name: "Westin Int")
    destination_two = create(:destination, featured: true)
    visit root_path

    expect(page).to have_content(destination_two.name)
    expect(page).not_to have_content(destination_one.name)
  end
end
