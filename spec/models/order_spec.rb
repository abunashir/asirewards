require 'rails_helper'

describe Order, "#status" do
  it "returns pending for non approved order" do
    order = create(:order)

    expect(order.status).to eq("Pending")
  end
end
