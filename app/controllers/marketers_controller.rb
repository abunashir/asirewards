class MarketersController < ApplicationController
  before_action :require_login

  def show
    redirect_to certificates_path
  end
end
