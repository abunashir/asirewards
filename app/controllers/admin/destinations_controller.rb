class Admin::DestinationsController < ApplicationController
  before_action :require_login
  layout "application.admin"

  def index
    @destinations = Destination.recent
  end

  def new
    build_destination
  end

  def create
    build_destination
    save_destination("destination.create.success") || render_errors
  end

  def edit
    load_destination
  end

  def update
    load_destination
    save_destination("destination.update.succsss") || render_errors(:edit)
  end

  private

  def load_destination
    @destination ||= Destination.friendly.find(params[:id])
  end

  def build_destination
    @destination ||= Destination.new
  end

  def save_destination(i18n_message = "destination.create.success")
    @destination.attributes = destination_params

    if @destination.save
      redirect_to(admin_destinations_path, notice: I18n.t(i18n_message))
    end
  end

  def render_errors(view = :new)
    flash.now[:error] = I18n.t("destination.create.errors")
    render view
  end

  def destination_params
    params.require(:destination).permit(
      :name, :banner, :content, :location, :country
    )
  end
end
