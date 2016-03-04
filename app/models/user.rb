class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :company

  has_many :certificates
  has_many :orders
  has_many :distributions, foreign_key: :sender_id

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  delegate :staffs, to: :company, allow_nil: true, prefix: true
end
