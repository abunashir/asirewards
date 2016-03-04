class Kit < ActiveRecord::Base
  belongs_to :certificate

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
