require "rails_helper"

describe User do
  describe "#management_admin?" do
    it "returns true when user is admin from the parent company" do
      company = create(:company, owner: true)
      user = create(:user, company: company, admin: true)

      expect(user.management_admin?).to eq(true)
    end
  end

  describe "#before_validation" do
    it "merge first name and last name into one field called name" do
      user = build(:user, name_part_one: "Keith", name_part_two: "Thomson")
      user.save

      expect(user.name).to eq("Keith Thomson")
    end
  end

  describe "#staff" do
    it "returns true for both admin or staff" do
      admin = create(:user, admin: true)
      user = create(:user, role: "staff")
      customer = create(:user, role: "customer")

      expect(admin.staff?).to eq(true)
      expect(user.staff?).to eq(true)
      expect(customer.staff?).to eq(false)
    end
  end
end

