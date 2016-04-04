require "rails_helper"

describe Booking do
  describe ".validations" do
    it { should validate_presence_of :destination }
    it { should validate_presence_of :confirmation_code }
    it { should validate_presence_of :check_in }
    it { should validate_presence_of :adults }
    it { should validate_presence_of :contact }
  end

  describe "#confirm" do
    it "books the requestable destination" do
      customer, certificate, destination = create_cert_customer_and_destination
      certificate.certificate.destinations << destination
      booking = build(
        :booking, confirmation_code: certificate.code, destination: destination
      )

      booking.confirm

      expect(booking.reload.kit).to eq(certificate)
      expect(booking.user).to eq(customer)
    end

    it "adds invalid destination error when destination is not requestable" do
      _customer, certificate, destination = create_cert_customer_and_destination
      booking = build(
        :booking, confirmation_code: certificate.code, destination: destination
      )

      booking.confirm

      expect(
        booking.errors.messages[:confirmation_code]

      ).to include("not valid for this destination")
    end
  end

  describe "#finalize_booking" do
    include ActiveJob::TestHelper

    it "delivers the booking confirmation" do
      booking = create(:booking)
      booking.finalize_booking

      expect(enqueued_jobs.size).to eq(2)
      expect(enqueued_jobs.last[:job]).to eq(ActionMailer::DeliveryJob)
      expect(enqueued_jobs.last[:args].first).to eq("BookingConfirmation")
      expect(enqueued_jobs.last[:args].last).to eq(booking.id)
    end

    it "mark the kit as booked" do
      booking = create(:booking, kit: create(:kit, used: true))
      booking.finalize_booking

      expect(booking.kit.reload.booked?).to eq(true)
    end
  end

  private

  def create_cert_customer_and_destination
    customer = create(:user)
    certificate = create(:certificate)
    destination = create(:destination)
    certificate.create_kit(number: 1)
    certificate_kit = certificate.available_kit

    certificate_kit.update(
      used: true, user: customer, activated_on: Time.now
    )

    [customer, certificate_kit, destination]
  end
end
