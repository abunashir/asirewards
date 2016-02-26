require "rails_helper"

describe Account do
  context "#admin" do
    it "returns the admin user from that company" do
      account = create(:account)
      user = create(:user, admin: true, company: account)

      expect(account.admin).to eq(user)
    end
  end
end
