require "rails_helper"

describe Purchase do
  describe "#execute" do
    it "returns the paypal payment object" do
      purchase = create(:purchase)

      stub_create_token_request
      stub_find_payment_request(purchase.payment_id)
      stub_execute_payment_request(purchase.payment_id)

      purchase.execute_payment("HZ4KQTL6VB7J6")

      expect(purchase.payment.id).to eq(purchase.payment_id)
      expect(purchase.payment.state).to eq("approved")
      expect(purchase.payment.payer).not_to be_nil
    end
  end

  describe "#create_payment" do
    it "returns the paypal payment object" do
      purchase = create(:purchase)

      stub_create_token_request
      stub_create_payment_request

      purchase.create_payment
      expect(purchase.payment_id).not_to be_nil

      expect(
        purchase.payment_gateway_url
      ).to match(/purchases\/asi-americas\/complete/)
    end
  end

  describe "#deliver_certificate" do
    it "add new certificate kit" do
      customer = create(:user)
      certificate = create(:certificate)
      purchase = create(:purchase, user: customer, certificate: certificate)

      purchase.deliver_certificate
      expect(customer.reload.kits.count).to eq(1)
    end
  end
end
