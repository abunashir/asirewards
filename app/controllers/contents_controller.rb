class ContentsController < ApplicationController
  before_action :require_login
  before_action :require_admin
  skip_before_filter :verify_authenticity_token, only: :create

  layout "certificate_content"

  def show
    build_content
  end

  def create
    build_content
    save_content || render_json_error
  end

  def update
    update_content || render_errors
  end

  private

  def certificate
    @certificate = Certificate.friendly.find(params[:certificate_id])
  end

  def build_content
    @content ||= certificate.content || certificate.contents.new
  end

  def save_content
    @content.attributes = certificate_params

    if @content.save
      render json: @content.id, status: :ok
    end
  end

  def update_content
    if certificate.publishable?
      redirect_to(
        certificates_path,
        notice: I18n.t("certificate.content.ready")
      )
    end
  end

  def render_errors
    flash[:error] = I18n.t("certificate.content.missing")
    redirect_to certificate_content_path(@certificate)
  end

  def render_json_error
    render json: {}, status: :unprocessable_entity
  end

  def certificate_params
    params.require(:content).permit(
      :banner, :title, :sub_title, :terms, :policies
    )
  end
end
