require "rails_helper"

describe Destination do
  describe ".validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :location }
    it { should validate_presence_of :country }
  end

  describe ".recent" do
    it "orders the destination by recently created at time" do
      destination_one = create(:destination, created_at: 10.days.ago)
      destination_two = create(:destination, created_at: Time.now)
      destination_three = create(:destination, created_at: 3.days.ago)

      expect(
        Destination.recent.map(&:id)
      ).to eq([destination_two, destination_three, destination_one].map(&:id))
    end
  end

  describe "#status" do
    it "returns status based on the active? status" do
      destination_one = create(:destination, active: true)
      destination_two = create(:destination, active: false)

      expect(destination_one.status).to eq("Active")
      expect(destination_two.status).to eq("Pending")
    end
  end
end
