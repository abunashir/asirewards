class Certificate < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :company
  has_many :kits, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_and_belongs_to_many :destinations

  accepts_nested_attributes_for :contents

  validates :name, presence: true
  validates :price, presence: true
  validates :expires_in, presence: true
  validates :duration, presence: true

  delegate :available_kit, to: :kits
  delegate :available?, to: :kits
  delegate :banner, :title, :sub_title, to: :content, allow_nil: true
  delegate :terms, :policies, to: :content, allow_nil: true

  def status
    number_of_available_kits > 0 ? "Active" : "Pending"
  end

  def approved?
    approved_on.present?
  end

  def create_kit(number:)
    number.to_i.times { |num|  kits.generate }
  end

  def number_of_available_kits
    kits.unused.size
  end

  def content
    contents.last
  end

  def send_certificate(user:)
    kit = kits.generate
    kit.user = user
    kit.send_certificate
  end
end
