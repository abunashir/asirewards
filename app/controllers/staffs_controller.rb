class StaffsController < ApplicationController
  before_action :require_login

  def index
    @staffs = staffs.limit(10)
  end

  def new
    @staff = staffs.new
  end

  def create
    @staff = staffs.new(staff_params)

    if @staff.save
      redirect_to staffs_path, notice: I18n.t("staff.create.success")
    else
      flash.now[:error] = I18n.t("staff.create.errors")
      render :new
    end
  end

  private

  def staffs
    current_user.company_staffs
  end

  def staff_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
