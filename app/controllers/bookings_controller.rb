class BookingsController < ApplicationController
  def new
    @booking = destination.bookings.new
  end

  def create
    @booking = destination.bookings.new(booking_params)

    if @booking.confirm
      @booking.deliver_confirmation
      redirect_to root_path, notice: I18n.t("booking.create.success")
    else
      render :new
    end
  end

  private

  def destination
    @destination = Destination.friendly.find(params[:destination_id])
  end

  def booking_params
    params.require(:booking).permit(
      :confirmation_code, :check_in, :adults, :children, :contact, :note
    )
  end
end
