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
end

