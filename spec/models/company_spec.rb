require "rails_helper"

describe Company do
  describe "#staffs" do
    it "returns the marketer and marketer_staff" do
      company   = create(:company)
      marketer  = create(:user, role: "staff", admin: true, company: company)
      staff     = create(:user, role: "staff", company: company)
      _customer = create(:user, role: "customer", company: company)

      expect(company.staffs.map(&:id).sort).to eq([marketer, staff].map(&:id))
    end
  end
end
