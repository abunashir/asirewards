class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :company
  has_many :certificates

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
