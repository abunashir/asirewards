class MarketersController < ApplicationController
  before_action :require_login

  def show
    if current_user.staff?
      redirect_to certificates_path
    else
      redirect_to root_path
    end
  end
end
