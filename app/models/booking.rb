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

  def confirmed
    if valid? && requestable?
      save
    end
  end

  def deliver_confirmation
    BookingConfirmation.confirmation(self.id).deliver_later
    BookingConfirmation.new_request(self.id).deliver_later
  end

  private

  def find_confirmed_kit
    self.kit = Kit.activated.find_by_code(confirmation_code.try(:upcase))
  end

  def requestable?
    destination && destination.requestable?(find_confirmed_kit.certificate)
  end
end
