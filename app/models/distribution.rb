class Distribution < ActiveRecord::Base
  belongs_to :kit
  belongs_to :sender, class_name: User, foreign_key: :sender_id

  attr_accessor :certificate_id

  validates :sender, presence: true
  validates :certificate_id, presence: true
  validates :kit, presence: true

  delegate :certificate_title, to: :kit

  def status
    activated_on.present? ? "Activated" : "Pending"
  end

  def send_certificate
    if certificate.available?
      self.kit = certificate.available_kit
      save
    end
  end

  def deliver_certificate
    CertificateSender.release(self.id).deliver_later
  end

  private

  def certificate
    sender.certificates.find(certificate_id)
  end
end
