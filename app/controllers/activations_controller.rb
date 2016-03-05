class ActivationsController < ApplicationController
  def index
  end

  def show
    if activation
      session[:activation_code] = params[:id]
      redirect_to new_activation_path
    end
  end

  def new
    @activation = activation || Activation.new
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
      render :new
    end
  end

  private

  def activation
    Activation.find_by_code(activation_code)
  end

  def activation_code
    session[:activation_code] || params[:id]
  end

  def activation_params
    params.require(:activation).permit(
      :activation_code, user_attributes: [:id, :name, :email, :phone]
    )
  end
end
