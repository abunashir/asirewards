require "rails_helper"

describe DestinationsHelper do
  describe "featured_destinations" do
    it "shows the featured destinations only" do
      destination_one = create(:destination, featured: true)
      _destination_two = create(:destination, featured: false)
      destination_three = create(:destination, featured: true)

      expect(
        featured_destinations.map(&:id)
      ).to eq([destination_three, destination_one].map(&:id))
    end
  end
end
