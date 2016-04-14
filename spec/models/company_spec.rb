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

  describe "#sellable_certificates" do
    it "includes the global certificate" do
      company = create(:company)
      certificate_one = create(:certificate, company: company)
      certificate_two = create(:certificate, global: true)
      _certificate_three = create(:certificate)

      expect(
        company.sellable_certificates.map(&:id)
      ).to eq([certificate_two, certificate_one].map(&:id))
    end
  end
end
