class Destination < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  validates :name, presence: true
  validates :location, presence: true
  validates :country, presence: true
  has_and_belongs_to_many :certificates

  mount_uploader :banner, BannerUploader

  def status
    active? ? "Active" : "Pending"
  end

  def self.recent(limit_to = 100)
    order(created_at: :desc).limit(limit_to)
  end

  private

  def slug_candidates
    [
      :name,
      [:name, :location],
      [:name, :location, :country]
    ]
  end
end
