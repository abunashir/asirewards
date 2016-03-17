class DestinationsController < ApplicationController
  before_action :require_login, only: [:new, :create]

  def index
    @destinations = Destination.recent
  end

  def show
    @destination = Destination.friendly.find(params[:id])
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)

    if @destination.save
      redirect_to(
        destinations_path, notice: I18n.t("destination.create.success")
      )
    else
      flash.now[:error] = I18n.t("destination.create.errors")
      render :new
    end
  end

  private

  def destination_params
    params.require(:destination).permit(
      :name, :banner, :content, :location, :country
    )
  end
end
