class Certificate < ActiveRecord::Base
  belongs_to :company
  has_many :kits

  validates :title, presence: true
  validates :sub_title, presence: true
  validates :terms, presence: true
  validates :policies, presence: true
  validates :price, presence: true

  delegate :available_kit, to: :kits
  delegate :available?, to: :kits

  mount_uploader :banner, BannerUploader

  def status
    approved? ? "Active" : "Pending"
  end

  def approved?
    approved_on.present?
  end

  def create_kit(number:)
    number.to_i.times { |num|  kits.generate }
  end
end
