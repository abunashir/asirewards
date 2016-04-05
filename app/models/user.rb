class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :company

  has_many :kits
  has_many :orders

  attr_accessor :name_part_one, :name_part_two
  before_validation :build_user_name

  validates :name, presence: true
  validates :email, presence: true
  validates :name_part_one, :name_part_two, presence: true, allow_blank: true

  delegate :staffs, :certificates, to: :company, allow_nil: true, prefix: true

  def management_admin?
    admin? && company.try(:owner?)
  end

  def staff?
    admin? || (role == "staff")
  end

  def account_type
    if admin?
      "Admin"
    elsif staff?
      "Staff"
    else
      "Customer"
    end
  end

  def self.staff
    select(&:staff?)
  end

  private

  def password_optional?
    !password.present?
  end

  def build_user_name
    if name_part_one.present?
      self.name = [name_part_one, name_part_two].compact.join(" ")
    end
  end
end
