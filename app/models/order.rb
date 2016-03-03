class Order < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user

  validates :certificate_id, presence: true
  validates :quantity, presence: true

  def status
    approved_on.present? ? "Approved" : "Pending"
  end
end
