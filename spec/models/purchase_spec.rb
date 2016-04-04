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

  describe "#finalize_purchase" do
    it "mark the purchase as paid" do
      customer = create(:user)
      certificate = create(:certificate)
      purchase = create(:purchase, user: customer, certificate: certificate)

      purchase.finalize_purchase
      expect(purchase.paid?).to eq(true)
    end

    it "send out the certfiicate" do
      customer = create(:user)
      certificate = create(:certificate)
      purchase = create(:purchase, user: customer, certificate: certificate)

      purchase.finalize_purchase
      expect(customer.reload.kits.count).to eq(1)
    end
  end
end
