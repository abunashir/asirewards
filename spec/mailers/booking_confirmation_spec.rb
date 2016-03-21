require "rails_helper"

describe CertificateSender do
  describe ".confirmation" do
    it "delivers the confirmation to the user" do
      booking = create(:booking, kit: create(:kit, user: create(:user)))
      email = BookingConfirmation.confirmation(booking.id)

      expect(email.subject).to include("Booking request received")
      expect(email.from).to include("noreply@asirewards.io")
      expect(email.to).to include(booking.user.email)
      expect(email.body.encoded).to include("Dear #{booking.user.name}")
      expect(email.body.encoded).to include("We are in receipt of your bookin")
    end
  end

  describe ".new_request" do
    it "sends the details to our staff" do
      support_staff = create(:user, email: "phluka@gmail.com")
      booking = create(
        :booking,
        kit: create(:kit, user: create(:user)),
        destination: create(:destination)
      )

      email = BookingConfirmation.new_request(booking.id)

      expect(email.subject).to include("Pending cert booking request")
      expect(email.from).to include("noreply@asirewards.io")
      expect(email.to).to include(support_staff.email)
      expect(email.body.encoded).to include("Hey #{booking.user.name}")
      expect(email.body.encoded).to include("A new booking request has been")
      expect(email.body.encoded).to include(booking.destination.name)
    end
  end
end
