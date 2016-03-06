class Kit < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user
  accepts_nested_attributes_for :user, reject_if: :all_blank

  delegate :title, to: :certificate, prefix: true

  def send_certificate
    if save
      mark_used!
    end
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
