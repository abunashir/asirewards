module DestinationsHelper
  def featured_destinations(limit_to = 6)
    Destination.featured(limit_to)
  end
end
