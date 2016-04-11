class DestinationsController < ApplicationController
  def index
    @destinations = Destination.recent
  end

  def show
    @destination = Destination.friendly.find(params[:id])
  end
end
