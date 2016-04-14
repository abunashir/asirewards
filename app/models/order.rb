class Order < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user

  validates :certificate_id, presence: true
  validates :quantity, presence: true

  def approve
    transaction do
      certificate.create_kit(number: quantity, business: user.company)
      touch :approved_on
    end
  end

  def status
    pending? ? "Pending" : "Approved"
  end

  def pending?
    !approved_on.present?
  end

  def self.pending
    where(approved_on: nil)
  end

  def self.recent(limit_to = 20)
    order(created_at: :desc).limit(limit_to)
  end
end
