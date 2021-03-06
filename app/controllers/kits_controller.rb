class KitsController < ApplicationController
  before_action :require_login
  before_action :require_staff

  def index
    @kits = certificate_kits.used.recent
  end

  def new
    @kit = certificate_kits.new
    @kit.build_user
  end

  def create
    @kit = certificate.available_kit(current_user.company)
    save_certificate_kit || render_errors(:new)
  end

  private

  def certificate
    @certificate ||= Certificate.friendly.find(params[:certificate_id])
  end

  def certificate_kits
    certificate.kits.where(company: current_user.company)
  end

  def save_certificate_kit
    set_certificate_kit_attributes

    if @kit.send_certificate
      redirect_to(
        certificate_kits_path(certificate), notice: I18n.t("kit.create.success")
      )
    end
  end

  def render_errors(view_partial)
    flash.now[:error] = I18n.t("kit.create.errors")
    render view_partial
  end

  def existing_user
    @user ||= User.find_by_email(kit_params[:user_attributes][:email])
  end

  def set_certificate_kit_attributes
    if existing_user
      flash.now[:success] = I18n.t("kit.create.existing_user")
      @kit.user = existing_user
    else
      @kit.attributes = kit_params
      @kit.user.company = current_user.company
    end
  end

  def kit_params
    params.require(:kit).permit(
      user_attributes: [:name, :email, :phone]
    )
  end
end
