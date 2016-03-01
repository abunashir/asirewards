class Certificate < ActiveRecord::Base
  belongs_to :user
  mount_uploader :banner, BannerUploader

  def status
    approved? ? "Active" : "Pending"
  end

  def approved?
    approved_on.present?
  end
end
