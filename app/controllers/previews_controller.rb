class PreviewsController < ApplicationController
  before_action :require_login

  def show
    @certificate = current_user.certificates.find(params[:certificate_id])
  end
end
