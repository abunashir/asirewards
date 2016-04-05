class UsersController < ApplicationController
  before_action :require_login

  def index
    @users = User.staff
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path, notice: I18n.t("user.create.success")
    else
      flash.now[:error] = I18n.t("user.create.errors")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone, :password)
  end
end
