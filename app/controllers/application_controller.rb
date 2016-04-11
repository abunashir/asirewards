class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  protect_from_forgery with: :exception

  def ssl_configured?
    !Rails.env.development?
  end

  private

  def require_management_admin
    unless current_user.management_admin?
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def require_staff
    unless current_user.staff?
      redirect_to root_path
    end
  end
end
