class Kit < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user
  accepts_nested_attributes_for :user

  delegate :title, :sub_title, :banner, :terms, :policies, to: :certificate

  def send_certificate
    if save
      mark_used!
    end
  end

  def deliver_certificate
    CertificateSender.release(self.id).deliver_later
  end

  def activation_code
    [certificate.code_prefix, code].compact.join.upcase
  end

  def mark_used!
    update_attributes! used: true
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

  def self.used
    where(used: true)
  end

  def self.unused
    where(used: false)
  end

  def self.recent(total = 10)
    order(created_at: :desc).limit(total)
  end

  def self.available?
    available_kit.present?
  end

  def self.available_kit
    where(used: false).order('random()').first
  end

  def self.generate
    create!(code: KitGenerator.new(length: 7).code)
  end
end
