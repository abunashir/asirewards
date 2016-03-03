class Order < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user

  validates :certificate_id, presence: true
  validates :quantity, presence: true

  def status
    approved_on.present? ? "Approved" : "Pending"
  end

  def approve
    transaction do
      certificate.create_kit(number: quantity)
      touch :approved_on
    end
  end

  def self.pending
    where(approved_on: nil)
  end
end
