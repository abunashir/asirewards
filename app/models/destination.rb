class Destination < ActiveRecord::Base
  validates :name, presence: true
  validates :location, presence: true
  validates :country, presence: true

  mount_uploader :banner, BannerUploader

  def status
    active? ? "Active" : "Pending"
  end

  def self.recent(limit_to = 100)
    order(created_at: :desc).limit(limit_to)
  end
end
