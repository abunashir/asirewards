class DestinationsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @destinations = Destination.recent
  end

  def show
    @destination = Destination.friendly.find(params[:id])
  end
end
