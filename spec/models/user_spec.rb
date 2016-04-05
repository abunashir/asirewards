require "rails_helper"

describe User do
  describe ".staff" do
    it "returns non customer users" do
      _customer = create(:user, role: nil)
      staff = create(:user, role: "staff")
      admin = create(:admin)

      expect(User.staff.map(&:id).sort).to eq([staff, admin].map(&:id).sort)
    end
  end

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

  describe "#staff?" do
    it "returns true for both admin or staff" do
      admin = create(:user, admin: true)
      user = create(:user, role: "staff")
      customer = create(:user, role: "customer")

      expect(admin.staff?).to eq(true)
      expect(user.staff?).to eq(true)
      expect(customer.staff?).to eq(false)
    end
  end

  describe "#account_type" do
    it "converts user role to account type" do
      customer = create(:user, role: nil)
      admin = create(:admin)
      staff = create(:user, role: "staff")

      expect(customer.account_type).to eq("Customer")
      expect(admin.account_type).to eq("Admin")
      expect(staff.account_type).to eq("Staff")
    end
  end
end
