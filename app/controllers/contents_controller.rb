class ContentsController < ApplicationController
  before_action :require_login
  skip_before_filter :verify_authenticity_token, only: :create

  layout "certificate_content"

  def show
    if ready_to_be_live?
      redirect_to(
        certificates_path,
        notice: I18n.t("certificate.content.create.ready")
      )

    else
      @content = certificate.content || certificate.contents.new
    end
  end

  def create
    @content = certificate.contents.last || certificate.contents.new
    @content.attributes = certificate_params

    respond_to do |format|
      if @content.save
        format.json { render json: @content.id, status: :ok }
      else
        format.json { render json: {}, status: :unprocessable_entity }
      end
    end
  end

  private

  def certificate
    @certificate = Certificate.find(params[:certificate_id])
  end

  def ready_to_be_live?
    if certificate.title && certificate.sub_title
      params[:ready] && params[:ready] == "true"
    end
  end

  def certificate_params
    params.require(:content).permit(
      :banner, :title, :sub_title, :terms, :policies
    )
  end
end
