class Certificate < ActiveRecord::Base
  belongs_to :user
  has_many :kits

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
