class Company < ActiveRecord::Base
  has_many :users
  has_many :certificates

  accepts_nested_attributes_for :users

  validates :name, presence: true

  def staffs
    users.where(role: "staff")
  end

  def sellable_certificates
    Certificate.global | certificates
  end
end
