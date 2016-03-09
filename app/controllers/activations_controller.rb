class ActivationsController < ApplicationController
  def index
    @activation = Activation.new
    @activation.build_user
  end

  def show
    if activation
      render :edit
    else
      redirect_to root_path
    end
  end

  def create
    if activation
      save_activation || render_errors(:index)
    else
      flash[:error] = I18n.t("cert.activation.errors")
      redirect_to root_path
    end
  end

  def update
    @activation = Activation.find(params[:id])
    save_activation || render_errors(:edit)
  end

  private

  def activation
    @activation = Activation.find_by_code(activation_code)
  end

  def activation_code
    params[:id] || params[:activation][:activation_code]
  end

  def save_activation
    @activation.attributes = activation_attributes

    if @activation.activate
      @activation.deliver_confirmation

      redirect_to(
        activations_path, notice: I18n.t("cert.activation.success")
      )
    end
  end

  def render_errors(view_partial)
    flash.now[:error] = I18n.t("cert.activation.errors")
    render view_partial
  end

  def activation_attributes
    form_attributes = activation_params

    if !form_attributes[:user_attributes][:id]
      form_attributes[:user_attributes][:id] = @activation.user_id
    end

    form_attributes
  end

  def activation_params
    params.require(:activation).permit(
      :activation_code,
      user_attributes: [:id, :name_part_one, :name_part_two, :email, :phone]
    )
  end
end
