class Kit < ActiveRecord::Base
  belongs_to :certificate

  def self.generate
    create!(code: KitGenerator.new(length: 7).code)
  end
end
