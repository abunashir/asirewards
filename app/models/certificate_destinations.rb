class CertificateDestinations
  include ActiveModel::Model
  attr_accessor :certificate, :destination_ids

  def save
    if valid?
      destinations = Destination.where(id: destination_ids.compact)
      certificate.destinations << destinations
    end
  end

  def selectable
    Destination.where.not(id: certificate.destinations)
  end
end
