class DistributionsController < ApplicationController
  before_action :require_login

  def index
    @distributions = Distribution.where(
      sender_id: current_user.company_staffs.map(&:id)
    )
  end

  def new
    @distribution = distributions.new
  end

  def create
    @distribution  = distributions.new(distribution_params)

    if @distribution.send_certificate
      @distribution.deliver_certificate
      redirect_to distributions_path
    else
      render :new
    end
  end

  private

  def distributions
    current_user.distributions
  end

  def distribution_params
    params.require(:distribution).permit(:certificate_id, :name, :email)
  end
end
