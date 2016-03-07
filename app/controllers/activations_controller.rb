class ActivationsController < ApplicationController
  def index
  end

  def show
    if activation
      render :edit
    else
      redirect_to root_path
    end
  end

  def create
    @activation = Activation.find_by_code(params[:activation][:activation_code])

    if @activation
      activation_attributes = activation_params
      activation_attributes[:user_attributes][:id] = @activation.user_id

      @activation.attributes = activation_attributes

      if @activation.activate
        @activation.deliver_confirmation

        redirect_to(
          activations_path, notice: I18n.t("cert.activation.success")
        )
      else
        render :index
      end
    end
  end

  def update
    @activation = Activation.find(params[:id])
    @activation.attributes = activation_params

    if @activation.activate
      @activation.deliver_confirmation

      redirect_to(
        activations_path, notice: "Your certificate has been activated"
      )
    else
      render :edit
    end
  end

  private

  def activation
    @activation = Activation.find_by_code(params[:id])
  end

  def activation_params
    params.require(:activation).permit(
      :activation_code, user_attributes: [:id, :name, :email, :phone]
    )
  end
end
