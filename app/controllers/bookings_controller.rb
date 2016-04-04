class BookingsController < ApplicationController
  def new
    @booking = destination.bookings.new
  end

  def create
    @booking = destination.bookings.new(booking_params)
    save_booking || render(:new)
  end

  private

  def destination
    @destination = Destination.friendly.find(params[:destination_id])
  end

  def save_booking
    if @booking.confirm
      @booking.finalize_booking
      redirect_to root_path, notice: I18n.t("booking.create.success")
    end
  end

  def booking_params
    params.require(:booking).permit(
      :confirmation_code, :check_in, :adults, :children, :contact, :note
    )
  end
end
