require 'rails_helper'

describe Order, "#status" do
  it "returns pending for non approved order" do
    order = create(:order)

    expect(order.status).to eq("Pending")
  end
end

describe Order, ".pending" do
  it "returns non approved orders" do
    order_one = create(:order)
    _order_two = create(:order, approved_on: Time.current)

    expect(Order.pending.map(&:id)).to eq([order_one.id])
  end
end

describe Order, "#approve" do
  it "sets the order as approved" do
    order = create(:order)

    order.approve
    order.reload

    expect(order.status).to eq("Approved")
  end

  it "generate total number of kits for that certificate" do
    order = create(:order, quantity: 50)
    order.approve

    expect(order.certificate.kits.count).to eq(50)
  end
end
