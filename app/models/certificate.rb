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

  delegate :banner, :title, :sub_title, to: :content, allow_nil: true
  delegate :terms, :policies, to: :content, allow_nil: true

  def status(user_company = nil)
    number_of_available_kits(user_company) > 0 ? "Active" : "Pending"
  end

  def approved?
    approved_on.present?
  end

  def create_kit(number:, business: nil)
    business ||= company
    number.to_i.times { |num|  kits.generate(business: business) }
  end

  def number_of_available_kits(user_company = nil)
    company_scope_kits(user_company).unused.size
  end

  def available_kit(user_company = nil)
    company_scope_kits(user_company).available_kit
  end

  def content
    contents.last
  end

  def send_certificate(user:)
    kit = kits.generate(business: company)
    kit.user = user

    kit.send_certificate
  end

  def self.global
    where(global: true)
  end

  private

  def company_scope_kits(user_company)
    user_company ||= company
    kits.where(company: user_company)
  end
end
