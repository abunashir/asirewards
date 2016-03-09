require "rails_helper"

describe User do
  describe "#management_admin?" do
    it "returns true when user is admin from the parent company" do
      company = create(:company, owner: true)
      user = create(:user, company: company, admin: true)

      expect(user.management_admin?).to eq(true)
    end
  end
end

