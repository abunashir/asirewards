class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  force_ssl if: :ssl_configured?
  protect_from_forgery with: :exception

  def ssl_configured?
    !Rails.env.development?
  end
end
