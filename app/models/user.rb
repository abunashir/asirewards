class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :company

  has_many :kits
  has_many :orders

  validates :name, presence: true
  validates :email, presence: true

  delegate :staffs, to: :company, allow_nil: true, prefix: true
  delegate :certificates, to: :company

  def management_admin?
    admin? && company.try(:owner?)
  end

  private

  def password_optional?
    !password.present?
  end
end
