require "rails_helper"

describe Booking do
  describe ".validations" do
    it { should validate_presence_of :destination }
    it { should validate_presence_of :confirmation_code }
    it { should validate_presence_of :check_in }
    it { should validate_presence_of :adults }
    it { should validate_presence_of :contact }
  end

  describe "#confirmed" do
    it "books the requestable destination" do
      customer = create(:user)
      certificate = create(:certificate)
      destination = create(:destination)
      certificate.destinations << destination

      certificate.create_kit(number: 1)
      certificate_kit = certificate.available_kit
      certificate_kit.update(
        used: true, user: customer, activated_on: Time.now
      )

      booking = build(
        :booking, confirmation_code: certificate_kit.code, destination: destination
      )

      booking.confirmed

      expect(booking.reload.kit).to eq(certificate_kit)
      expect(booking.user).to eq(customer)
    end
  end

  describe "#deliver_confirmation" do
    include ActiveJob::TestHelper

    it "enque booking confirmation email" do
      booking = create(:booking)
      booking.deliver_confirmation

      expect(enqueued_jobs.size).to eq(2)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("BookingConfirmation")
      expect(enqueued_jobs.last[:args].last).to eq(booking.id)
    end
  end
end
