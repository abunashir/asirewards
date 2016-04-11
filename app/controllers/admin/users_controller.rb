class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action :require_management_admin

  layout "application.admin"

  def index
    @users = User.staff
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: I18n.t("user.create.success")
    else
      flash.now[:error] = I18n.t("user.create.errors")
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
