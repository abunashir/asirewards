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

  describe ".featured" do
    it "returns the latest updated featured destinations" do
      destination_one = create(:destination, featured: true)
      _destination_two = create(:destination, featured: false)
      destination_three = create(:destination, featured: true)

      expect(
        Destination.featured.map(&:id)
      ).to eq([destination_three, destination_one].map(&:id))
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

  describe "#requestable?" do
    it "returns the requestable status for a specific certificate" do
      certificate = create(:certificate)
      destination_one = create(:destination)
      destination_two = create(:destination)
      certificate.destinations << destination_one

      expect(destination_one.requestable?(certificate)).to eq(true)
      expect(destination_two.requestable?(certificate)).to eq(false)
    end
  end
end
