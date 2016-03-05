class Kit < ActiveRecord::Base
  belongs_to :certificate
  belongs_to :user
  accepts_nested_attributes_for :user

  delegate :title, to: :certificate, prefix: true

  def mark_used!
    update_attributes! used: true
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
