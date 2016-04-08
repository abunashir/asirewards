class BookingConfirmation < ApplicationMailer
  default from: "ASI Rewards <noreply@asirewards.io>"

  def confirmation(booking_id)
    @booking = Booking.find(booking_id)
    mail to: @booking.user.email, subject: "Booking request received"
  end

  def new_request(booking_id)
    @booking = Booking.find(booking_id)
    @staff = company_support_staff
    mail to: @staff.email, subject: "Pending cert booking request"
  end
end
