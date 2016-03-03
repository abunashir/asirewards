class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :company

  has_many :certificates
  has_many :orders

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
