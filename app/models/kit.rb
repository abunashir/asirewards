class Kit < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user
  belongs_to :company
  accepts_nested_attributes_for :user

  delegate :name, :title, :sub_title, :banner, to: :certificate
  delegate :terms, :policies, to: :certificate

  def send_certificate
    if save
      deliver_certificate
      mark_used!
    end
  end

  def activation_code
    [certificate.code_prefix, code].compact.join.upcase
  end

  def status
    if activated?
      "Activated"
    elsif used?
      "Pending"
    else
      "Ready"
    end
  end

  def activated?
    used? && activated_on.present?
  end

  def booked?
    used? && booked_on.present?
  end

  def mark_booked
    touch :booked_on
  end

  def self.used
    where(used: true)
  end

  def self.unused
    where(used: false)
  end

  def self.recent(total = 10)
    order(created_at: :desc).limit(total)
  end

  def self.activated
    used.where(booked_on: nil).where.not(activated_on: nil)
  end

  def self.available_kit
    where(used: false).order('random()').first
  end

  def self.generate(business:)
    create!(code: KitGenerator.new(length: 7).code, company: business)
  end

  private

  def mark_used!
    update_attributes! used: true
  end

  def deliver_certificate
    CertificateSender.release(self.id).deliver_later
  end
end
