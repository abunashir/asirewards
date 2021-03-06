class Booking < ActiveRecord::Base
  belongs_to :destination
  belongs_to :kit
  attr_accessor :confirmation_code

  validates :destination, presence: true
  validates :confirmation_code, presence: true
  validates :check_in, presence: true
  validates :adults, presence: true
  validates :contact, presence: true

  delegate :user, to: :kit, allow_nil: true

  def confirm
    if valid? && requestable?
      save
    end
  end

  def finalize_booking
    deliver_confirmation
    kit.mark_booked
  end

  private

  def find_confirmed_kit
    self.kit = Kit.activated.find_by_code(confirmation_code.try(:upcase))
  end

  def requestable?
    requestable = destination &&
      destination.requestable?(find_confirmed_kit.certificate)

    if !requestable
      errors.add(:confirmation_code, "not valid for this destination")
    end

    requestable
  end

  def deliver_confirmation
    BookingConfirmation.confirmation(self.id).deliver_later
    BookingConfirmation.new_request(self.id).deliver_later
  end
end
